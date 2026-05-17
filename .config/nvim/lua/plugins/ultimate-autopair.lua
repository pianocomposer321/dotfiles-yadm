return {
    'altermo/ultimate-autopair.nvim',
    event = {'InsertEnter','CmdlineEnter'},
    branch = 'v0.6', --recommended as each new version will have breaking changes
    opts = {
        fastwarp = {
            map = '<c-a>',
            rmap = '<c-e>',
        },
        {"$", "$", newline = true, space = true, ft = {"tex", "typst"}}
    }
    -- opts={
    --     --Config goes here
    -- },
}
