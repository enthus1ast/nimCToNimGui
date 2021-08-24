import nigui, os, strformat

let
  CFILE = "out.c"
  NIMFILE = "out.nim"
  C2NIM = getHomeDir() / """.choosenim/toolchains/nim-0.19.6/bin/c2nim""" & ExtSep & ExeExt

let
  cinfile = getAppDir() / CFILE
  nimoutfile = getAppDir() / NIMFILE

proc main() =
  app.init()
  var window = newWindow("c to nim gui")
  var container = newLayoutContainer(Layout_Vertical)
  window.add(container)

  var cin = newTextArea()
  if fileExists(cinfile):
    cin.text = readFile(cinfile)
  container.add(cin)

  var nout = newTextArea()
  if fileExists(nimoutfile):
    nout.text = readFile(nimoutfile)
  container.add(nout)

  var button = newButton("gen")
  button.onClick = proc(event: ClickEvent) =
    writeFile(getAppDir() / CFILE, cin.text)
    echo execShellCmd(fmt("{C2NIM} {CFILE} -o {NIMFILE}"))
    if fileExists(nimoutfile):
      nout.text = readFile(nimoutfile)
  container.add(button)
  window.show()
  app.run()

when isMainModule:
  main()

