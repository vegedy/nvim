
function CompileLatex()
  -- Kompilierungsbefehl
  local compile_cmd = 'latexmk -pdf -xelatex -bibtex ' .. vim.fn.shellescape(vim.fn.expand('%:p'))

  -- Kompilieren
  vim.notify('Kompiliere...')
  local compile_output = vim.fn.system(compile_cmd)

  if vim.v.shell_error ~= 0 then
    print('❌ Kompilierungsfehler:')
    print(compile_output)
    return
  end

  vim.notify('✔ Kompilierung abgeschlossen')
end

function ViewLatex()
  -- PDF anzeigen
  local pdf_path = vim.fn.expand('%:p:r') .. '.pdf'
  local pdf_viewer_cmd = 'zathura ' .. vim.fn.shellescape(pdf_path) .. ' &'

  vim.fn.system(pdf_viewer_cmd)
end

