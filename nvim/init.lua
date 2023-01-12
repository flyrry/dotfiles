require('settings')

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins')

require ('mappings')

--{{{
-- === CHEAT SHEET ===
-- --- splits ---
-- {N}c-w _ # max out the height of the current split (or set to N)
-- {N}c-w | # max out the width of the current split (or set to N)
-- c-w = # normalize all split sizes
-- c-w r # swap left/right or top/bottom splits
-- {N}c-w + # increase window height by one (or by N)
-- {N}c-w - # decrease window height by one (or by N)
-- {N}c-w > # increase window width by one (or by N)
-- {N}c-w < # decrease window width by one (or by N)
-- --- mappings ---
--  S # replace
-- --- plugins ---
-- :.Gbrowse # open browser with current line highlighted
-- :.Gbrowse! # copy URL
-- :go # focus mode toggle
-- ,tl # list TODOs in location window (:lcl closes it)
--
--}}}

-- vim: foldmethod=marker:foldenable:
