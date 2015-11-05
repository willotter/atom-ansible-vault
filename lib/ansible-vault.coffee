AnsibleVaultView = require './ansible-vault-view'
{CompositeDisposable} = require 'atom'
{execFile} = require('child_process')

module.exports = AnsibleVault =
  ansibleVaultView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @ansibleVaultView = new AnsibleVaultView(state.ansibleVaultViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @ansibleVaultView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'ansible-vault:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @ansibleVaultView.destroy()

  serialize: ->
    ansibleVaultViewState: @ansibleVaultView.serialize()

  toggle: ->
    options =
        cwd: __dirname + "/../"
    if editor = atom.workspace.getActiveTextEditor()
        pass = "test"
        path = editor.getPath()
        console.log path
        execFile 'bin/vault_wrapper.py', [pass ,path], options,  (error, stdout, stderr) ->
            editor.setText(stdout)
            console.log stdout
            return
