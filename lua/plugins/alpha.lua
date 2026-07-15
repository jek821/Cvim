-----------------------------------------------------------
-- Alpha (start screen) configuration
-----------------------------------------------------------

local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- Banner ------------------------------------------------------

local banner = {
  type = "text",
  val = {
    "   ██  █████  █   █         █   █  █████  █   █  ",
    "    █  █      █  █          █   █    █    ██ ██  ",
    "    █  ████   ███           █   █    █    █ █ █  ",
    "    █  █      █  █          █   █    █    █   █  ",
    "█   █  █      █   █          █ █     █    █   █  ",
    " ███   █████  █   █  █████    █    █████  █   █  ",
  },
  opts = { position = "center", hl = {} },
}

-- Cycling color wave across the banner rows -------------------------

local banner_palette = { "Function", "Special", "Identifier", "Type", "Constant", "String", "Title", "DiagnosticHint" }
local banner_offset = 0

local function set_banner_hl()
  local hl = {}
  for i = 1, #banner.val do
    local group = banner_palette[((banner_offset + i - 1) % #banner_palette) + 1]
    table.insert(hl, { { group, 0, -1 } })
  end
  banner.opts.hl = hl
end
set_banner_hl()

-- Buttons ------------------------------------------------------

dashboard.section.buttons.val = {
  dashboard.button("f", "Find file", ":Telescope find_files<CR>"),
  dashboard.button("r", "Recent files", ":Telescope oldfiles<CR>"),
  dashboard.button("g", "Live grep", ":Telescope live_grep<CR>"),
  dashboard.button("n", "New file", ":ene <BAR> startinsert<CR>"),
  dashboard.button("e", "File explorer", ":NvimTreeToggle<CR>"),
  dashboard.button("q", "Quit", ":qa<CR>"),
}

-- Fun facts ------------------------------------------------------
-- A curated science/history list (always available, offline-safe),
-- topped up on each launch with real "on this day" history facts
-- fetched from Wikipedia -- so the pool keeps growing and changes
-- daily instead of being a fixed, ever-repeating set.

local static_facts = {
  "Octopuses have three hearts and blue, copper-based blood.",
  "A bolt of lightning is roughly five times hotter than the surface of the sun.",
  "Honey never spoils; sealed honey from 3,000-year-old Egyptian tombs was still edible.",
  "A day on Venus is longer than its year: it rotates once every 243 Earth days but orbits the sun in 225.",
  "Sharks have existed for about 400 million years, predating trees by roughly 50 million years.",
  "Bananas are naturally slightly radioactive because of their potassium content.",
  "Glass windowpanes are not a slow-moving liquid; old panes are thicker at the bottom due to how they were made.",
  "Gallium metal melts at about 30C, so it turns to liquid in the palm of your hand.",
  "Wombats produce cube-shaped droppings, which keeps them from rolling away.",
  "The Eiffel Tower grows about 15cm taller in summer as its iron expands in the heat.",
  "The human brain uses about 20% of the body's energy despite being only ~2% of its weight.",
  "Cleopatra lived closer in time to the Moon landing than to the building of the Great Pyramid of Giza.",
  "Oxford University was already teaching students before the Aztec Empire existed.",
  "The Anglo-Zanzibar War of 1896, the shortest war on record, lasted about 38 minutes.",
  "Vikings reached North America around 1000 CE, about 500 years before Columbus.",
  "Paper money was first used in China over a thousand years ago, during the Tang and Song dynasties.",
  "A neutron star is so dense a teaspoon of it would weigh about 10 million tons on Earth.",
  "Water can be made to boil and freeze at the same time at its triple point.",
  "Roman concrete used in seawater structures gets stronger over time, unlike modern concrete.",
  "There are more possible chess games than atoms in the observable universe.",
}

local facts = {}
for _, f in ipairs(static_facts) do
  table.insert(facts, f)
end

local function shuffle(t)
  for i = #t, 2, -1 do
    local j = math.random(i)
    t[i], t[j] = t[j], t[i]
  end
end

math.randomseed(os.time())
shuffle(facts)
local fact_index = 1

-- Fact card ------------------------------------------------------

local fact_section = { type = "text", val = {}, opts = { position = "center", hl = "Comment" } }

local function build_card(text)
  local width = math.max(30, math.min(64, vim.o.columns - 12))
  local words = {}
  for w in text:gmatch("%S+") do
    table.insert(words, w)
  end

  local wrapped, line = {}, ""
  for _, w in ipairs(words) do
    local candidate = line == "" and w or (line .. " " .. w)
    if vim.fn.strdisplaywidth(candidate) > width then
      table.insert(wrapped, line)
      line = w
    else
      line = candidate
    end
  end
  if line ~= "" then
    table.insert(wrapped, line)
  end

  local box, hl = { "╭" .. string.rep("─", width + 2) .. "╮" }, { { { "Special", 0, -1 } } }
  table.insert(box, "│ " .. string.rep(" ", width) .. " │")
  table.insert(hl, { { "Special", 0, -1 } })
  for _, l in ipairs(wrapped) do
    local pad = width - vim.fn.strdisplaywidth(l)
    table.insert(box, "│ " .. l .. string.rep(" ", pad) .. " │")
    table.insert(hl, { { "String", 0, -1 } })
  end
  table.insert(box, "│ " .. string.rep(" ", width) .. " │")
  table.insert(hl, { { "Special", 0, -1 } })
  table.insert(box, "╰" .. string.rep("─", width + 2) .. "╯")
  table.insert(hl, { { "Special", 0, -1 } })
  return box, hl
end

local function set_fact_text()
  local box, hl = build_card("✧ " .. facts[fact_index])
  fact_section.val = box
  fact_section.opts.hl = hl
end
set_fact_text()

-- Layout ------------------------------------------------------

dashboard.config.layout = {
  { type = "padding", val = 1 },
  banner,
  { type = "padding", val = 2 },
  dashboard.section.buttons,
  { type = "padding", val = 2 },
  fact_section,
  { type = "padding", val = 1 },
}

-- Fetch today's history facts from Wikipedia's "On this day" API ----
-- Non-blocking: the dashboard already shows the static list while
-- this runs, and silently keeps the static list if it fails/offline.

local fetched_today = false

local function format_year(y)
  if y < 0 then
    return string.format("%d BCE", -y)
  end
  return tostring(y)
end

local function fetch_history_facts()
  if fetched_today or vim.fn.executable("curl") ~= 1 then
    return
  end
  fetched_today = true

  local url = string.format(
    "https://en.wikipedia.org/api/rest_v1/feed/onthisday/all/%02d/%02d",
    tonumber(os.date("%m")),
    tonumber(os.date("%d"))
  )

  vim.system(
    { "curl", "-s", "--max-time", "4", "-H", "User-Agent: nvim-dashboard/1.0", url },
    { text = true },
    vim.schedule_wrap(function(res)
      if res.code ~= 0 or not res.stdout or res.stdout == "" then
        return
      end
      local ok, decoded = pcall(vim.json.decode, res.stdout)
      if not ok or type(decoded) ~= "table" then
        return
      end

      local new_facts = {}
      for _, key in ipairs({ "selected", "events" }) do
        for _, entry in ipairs(decoded[key] or {}) do
          if entry.text and entry.year then
            table.insert(new_facts, format_year(entry.year) .. " — " .. entry.text)
          end
        end
      end
      if #new_facts == 0 then
        return
      end

      for _, f in ipairs(new_facts) do
        table.insert(facts, f)
      end
      shuffle(facts)
      fact_index = 1
      set_fact_text()
      if vim.bo.filetype == "alpha" then
        pcall(alpha.redraw)
      end
    end)
  )
end

-- Cycle the fact every 20s while the alpha buffer is open -----------

local uv = vim.uv or vim.loop
local fact_timer = nil

local function stop_fact_timer()
  if fact_timer then
    fact_timer:stop()
    fact_timer:close()
    fact_timer = nil
  end
end

local function start_fact_timer()
  if fact_timer then
    return
  end
  fact_timer = uv.new_timer()
  fact_timer:start(
    20000,
    20000,
    vim.schedule_wrap(function()
      fact_index = (fact_index % #facts) + 1
      set_fact_text()
      if vim.bo.filetype == "alpha" then
        pcall(alpha.redraw)
      end
    end)
  )
end

-- Animate the banner's colors while the dashboard is open -----------

local color_timer = nil

local function stop_color_timer()
  if color_timer then
    color_timer:stop()
    color_timer:close()
    color_timer = nil
  end
end

local function start_color_timer()
  if color_timer then
    return
  end
  color_timer = uv.new_timer()
  color_timer:start(
    250,
    250,
    vim.schedule_wrap(function()
      banner_offset = (banner_offset + 1) % #banner_palette
      set_banner_hl()
      if vim.bo.filetype == "alpha" then
        pcall(alpha.redraw)
      end
    end)
  )
end

-- Hide the cursor while the dashboard is showing -------------------
-- Every default guicursor entry (block/ver/hor) falls back to the
-- built-in "Cursor" highlight group when no group is named explicitly,
-- so blending *that* group to fully transparent hides the cursor
-- regardless of shape, instead of fighting guicursor's mode matching.

local function hide_cursor()
  local hl = vim.api.nvim_get_hl(0, { name = "Cursor" })
  hl.blend = 100
  vim.api.nvim_set_hl(0, "Cursor", hl)
  vim.opt.guicursor:append("a:Cursor/lCursor")
end

local function restore_cursor()
  local hl = vim.api.nvim_get_hl(0, { name = "Cursor" })
  hl.blend = 0
  vim.api.nvim_set_hl(0, "Cursor", hl)
  vim.opt.guicursor:remove("a:Cursor/lCursor")
end

vim.api.nvim_create_autocmd("User", {
  pattern = "AlphaReady",
  callback = function()
    start_fact_timer()
    start_color_timer()
    fetch_history_facts()
    -- deferred: catppuccin re-applies its colorscheme on VimEnter too,
    -- which would otherwise reset the Cursor highlight right after we
    -- blend it, since both fire on the same event
    vim.schedule(hide_cursor)
    vim.api.nvim_create_autocmd({ "BufUnload", "BufWipeout" }, {
      buffer = vim.api.nvim_get_current_buf(),
      once = true,
      callback = function()
        stop_fact_timer()
        stop_color_timer()
        restore_cursor()
      end,
    })
  end,
})

alpha.setup(dashboard.opts)
