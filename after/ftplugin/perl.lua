-- Perl's official documentation states that code should have 4-column indent
-- https://perldoc.perl.org/perlstyle
-- Apache says it should use tabs instead of spaces
-- https://cwiki.apache.org/confluence/display/VCL/Perl+Code+Style+Guidelines
-- So, here's the amalgamaton

-- Use tabs
vim.bo.expandtab = false
-- Use 4 columns visually
vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
