require("user.lsp_utils").extend_on_attach(function(client)
  -- Disable semantic highlighting for qmlls because it's often
  -- inaccurate/slow
  if client.name == "qmlls" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end)
