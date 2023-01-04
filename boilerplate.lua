-- boilerplate.lua
-- Copyright 2022 Josef Friedrich
--
-- This work may be distributed and/or modified under the
-- conditions of the LaTeX Project Public License, either version 1.3c
-- of this license or (at your option) any later version.
-- The latest version of this license is in
--   http://www.latex-project.org/lppl.txt
-- and version 1.3c or later is part of all distributions of LaTeX
-- version 2008/05/04 or later.
--
-- This work has the LPPL maintenance status `maintained'.
--
-- The Current Maintainer of this work is Josef Friedrich.
--
-- This work consists of the files boilerplate.lua, boilerplate.tex,
-- and boilerplate.sty.
---
---Small library to surround strings with ANSI color codes.
---
---The upstream source is located at: [boilerplate.lua](https://github.com/Josef-Friedrich/tex-project-boilerplate/blob/main/boilerplate.lua)
--
---[SGR (Select Graphic Rendition) Parameters](https://en.wikipedia.org/wiki/ANSI_escape_code#SGR_(Select_Graphic_Rendition)_parameters)
---
---__attributes__
---
---| color      |code|
---|------------|----|
---| reset      |  0 |
---| clear      |  0 |
---| bright     |  1 |
---| dim        |  2 |
---| underscore |  4 |
---| blink      |  5 |
---| reverse    |  7 |
---| hidden     |  8 |
---
---__foreground__
---
---| color      |code|
---|------------|----|
---| black      | 30 |
---| red        | 31 |
---| green      | 32 |
---| yellow     | 33 |
---| blue       | 34 |
---| magenta    | 35 |
---| cyan       | 36 |
---| white      | 37 |
---
---__background__
---
---| color      |code|
---|------------|----|
---| onblack    | 40 |
---| onred      | 41 |
---| ongreen    | 42 |
---| onyellow   | 43 |
---| onblue     | 44 |
---| onmagenta  | 45 |
---| oncyan     | 46 |
---| onwhite    | 47 |
---
---@alias ColorName `black'|'red'|'green'|'yellow'|'blue'|'magenta'|'cyan'|'white`
---@alias ColorMode `bright'|'dim`
local ansi_color = (function()

  ---
  ---@param code integer
  ---
  ---@return string
  local function format_color_code(code)
    return string.char(27) .. '[' .. tostring(code) .. 'm'
  end

  ---
  ---@param color ColorName # A color name.
  ---@param mode? ColorMode
  ---@param background? boolean # Colorize the background not the text.
  ---
  ---@return string
  local function get_color_code(color, mode, background)

    local output = ''
    local code

    if mode == 'bright' then
      output = format_color_code(1)
    elseif mode == 'dim' then
      output = format_color_code(2)
    end

    if not background then
      if color == 'reset' then
        code = 0
      elseif color == 'red' then
        code = 31
      elseif color == 'green' then
        code = 32
      elseif color == 'yellow' then
        code = 33
      elseif color == 'blue' then
        code = 34
      elseif color == 'magenta' then
        code = 35
      elseif color == 'cyan' then
        code = 36
      else
        code = 37
      end
    else
      if color == 'black' then
        code = 40
      elseif color == 'red' then
        code = 41
      elseif color == 'green' then
        code = 42
      elseif color == 'yellow' then
        code = 43
      elseif color == 'blue' then
        code = 44
      elseif color == 'magenta' then
        code = 45
      elseif color == 'cyan' then
        code = 46
      elseif color == 'white' then
        code = 47
      else
        code = 40
      end
    end
    return output .. format_color_code(code)
  end

  ---@param text any
  ---@param color ColorName # A color name.
  ---@param mode? ColorMode
  ---@param background? boolean # Colorize the background not the text.
  ---
  ---@return string
  local function surround_text(text, color, mode, background)
    return string.format('%s%s%s',
      get_color_code(color, mode, background), text,
      get_color_code('reset'))
  end

  return {
    ---
    ---@param text any
    ---
    ---@return string
    red = function(text)
      return surround_text(text, 'red')
    end,

    ---
    ---@param text any
    ---
    ---@return string
    green = function(text)
      return surround_text(text, 'green')
    end,

    ---
    ---@param text any
    ---
    ---@return string
    white = function(text)
      return surround_text(text, 'white')
    end,
    ---@return string
    yellow = function(text)
      return surround_text(text, 'yellow')
    end,

    ---
    ---@param text any
    ---
    ---@return string
    blue = function(text)
      return surround_text(text, 'blue')
    end,

    ---
    ---@param text any
    ---
    ---@return string
    cyan = function(text)
      return surround_text(text, 'cyan')
    end,
  }
end)()

---
---Small logging library.
---
---The upstream source is located at: [boilerplate.lua](https://github.com/Josef-Friedrich/tex-project-boilerplate/blob/main/boilerplate.lua)
---
---Log levels:
---
---* 0: silent
---* 1: error (red)
---* 2: warn (yellow)
---* 3: info (green)
---* 4: verbose (blue)
---* 5: debug (magenta)
---
local log = (function()
  local opts = { verbosity = 0 }

  local function print_message(message, ...)
    print(string.format(message, ...))
  end

  local function error(message, ...)
    if opts.verbosity >= 1 then
      print_message(message, ...)
    end
  end

  local function warn(message, ...)
    if opts.verbosity >= 2 then
      print_message(message, ...)
    end
  end

  local function info(message, ...)
    if opts.verbosity >= 3 then
      print_message(message, ...)
    end
  end

  local function verbose(message, ...)
    if opts.verbosity >= 4 then
      print_message(message, ...)
    end
  end

  local function debug(message, ...)
    if opts.verbosity >= 5 then
      print_message(message, ...)
    end
  end

  return {
    opts = opts,
    error = error,
    warn = warn,
    info = info,
    verbose = verbose,
    debug = debug,
  }
end)()

log.opts.verbosity = 3

return {
  boilerplate = function()
    return 'boilerplate'
  end,
}
