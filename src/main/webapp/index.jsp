<%@page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width,
					initial-scale=1,
					maximum-scale=1,
					viewport-fit=cover" />
		<link rel="stylesheet" href="/bootstrap.css" />
		<title>minimal</title>
	</head>
	<body>
		<div class="container-fluid">
			<div class="input-group"
				 id="command-bar">
				<a class="btn btn-outline-secondary command-bar-element"
				   data-bs-toggle="dropdown"
					>minimal</a>
				<ul class="dropdown-menu" id="project-menu">
				</ul>
				<input
					id="command"
					class="form-control monospace command-bar-element"
					spellcheck="false" 
					autocapitalize="off" />
				<a class="btn btn-outline-secondary command-bar-element"
				   style="border-top-right-radius:.4rem; 
							border-bottom-right-radius:.4rem;
				   "
					data-bs-toggle="dropdown">&nbsp;
				</a>
				<ul class="dropdown-menu">
					<li><a class="dropdown-item"
						   href="javascript:execute()"
						   >Execute</a></li>
					<li><a class="dropdown-item" 
						   href="javascript:showFolder()"
						   >Browse</a></li>
					<li><a class="dropdown-item"
						   href="javascript:saveFile()"
						   >Save File</a></li>
					<li><a class="dropdown-item"
						   href="javascript:closeFile()"
						   >Close File</a></li>
					<li><hr class="dropdown-divider" /></li>
					<li><a class="dropdown-item"
						   href="javascript:switchTheme()"
						   >Switch Theme</a></li>
					<li><a class="dropdown-item"
						   href="javascript:runC()"
						   >Run C</a></li>
					<li><a class="dropdown-item"
						   href="javascript:runJava()"
						   >Run Java</a></li>
					<li><a class="dropdown-item"
						   href="javascript:runJavaScript()"
						   >Run JavaScript</a></li>
					<li><hr class="dropdown-divider" /></li>
					<li><a class="dropdown-item disabled"
						   href=""
						   >Download Folder</a></li>
					<li><a class="dropdown-item disabled"
						   href=""
						   >Lock Screen</a></li>
				</ul>
			</div>
		</div>
		
		<div id="command-result">
			<div class="container-fluid">
				<a href="javascript:clearResult()"
				   class="btn btn-sm btn-danger"
				   style="float:right; margin: 1.25rem 0; ">Clear</a>
			</div>
			<div class="container-fluid monospace">	
			</div>
		</div>
		
		<div id="folder-result">
			<div class="container-fluid">
				<a href="javascript:closeFolder()"
				   class="btn btn-sm btn-danger"
				   style="float:right; margin: 1.25rem 0; ">Close</a>
			</div>
			<div class="container-fluid monospace" id="folder-target">	
			</div>
		</div>
		
		<div id="web-view">
			<div class="container-fluid">
				<a href="javascript:closeView()"
				   class="btn btn-sm btn-danger"
				   style="float:right; margin-top: 0.2rem; ">Close</a>
			</div>
			<div class="container-fluid" id="web-view-detail">
			</div>
		</div>
		
		<div class="container-fluid">
			<textarea
				id="editor"
				class="form-control editor-element monospace"
				spellcheck="false"
				rows="8"
>#include <stdio.h>
int main(void) {
	for (int i = 0; i < 10; i++) {
		printf("Value %d\n", i);
	}
	return 0;
}
</textarea>
		</div>
		
		<style>
			:root {
				--editor: white;
				--editor-text: #333;
				--editor-line: #bbb;
			}
			
			body {
				background: var(--editor);
			}
			
			.container-fluid {
			}
			
			#command-bar {
				margin-top: 0.5rem;
			}
			
			#command {
				color: var(--editor-text);
			}
			
			.command-bar-element {
				max-height: 2.4rem;
				border-color: var(--editor-line);
			}
			
			.monospace {
				font-family: monospace;
				font-size: 1.15rem;
				border-radius: .4rem;
			}
			
			code {
				font-size: 0.65rem;
			}
			
			.btn {
				border-radius: .4rem;
			}
			
			textarea {
				height: calc(100vh - 4.2rem);
				-moz-tab-size: 4;
				tab-size: 4;
				margin-top: 0.5rem;
				resize: none;
			}
			
			.form-control {
				background: var(--editor);
				color: var(--editor-text);
				border-color: var(--editor-line);
			}
			
			.form-control:focus {
				outline: 0 !important;
				box-shadow: none;
				background: var(--editor);
				color: var(--editor-text);
				border-color: var(--editor-line);
			}
			
			#command-result,
			#folder-result {
				position: absolute;
				z-index: -10;
				width: calc(100% - 1.5rem);
				height: calc(100vh - 4.2rem);
				margin-top: 0.5rem;
				margin-left: 0.75rem;
				min-height: 3.5rem;
				border-radius: .4rem;
				overflow-y: scroll;
				opacity: .95;
				color: var(--editor-text);
				background: var(--editor);
				border: 1px solid var(--editor-line);
			}
			
			#folder-result {
				
			}
			
			#folder-target {
				font-family: monospace;
			}
			
			#folder-target a {
				text-decoration: none;
				color: var(--editor-text);
				opacity: .75;
			}
			
			#folder-target a:hover {
				opacity: 1.0;
			}
			
			.dropdown-menu {
				background: #aaa;
				opacity: .95;
			}
			
			code {
				color: var(--editor-text);
			}
			
			body {
				scrollbar-color: rgba(128,128,128, .5)
								 rgba(128,128,128, 0);
			}
			
			@media(max-width:575px) {
				#editor {
					font-size: 0.85rem;
					height: calc(100vh - 11rem);
					border-bottom-left-radius: 1.5rem;
					border-bottom-right-radius: 1.5rem;
				}
				#command-result,
				#folder-result{
					height: calc(100vh - 11.5rem);
					border-radius: 1.2rem;
				}
				.btn {
					
				}
			}
			
			::-webkit-scrollbar {
				width: .5rem;
			}

			::-webkit-scrollbar-track {
				background: rgba(128,128,128, 0.0);
			}

			::-webkit-scrollbar-thumb {
				background: rgba(128,128,128, 0.8);
				border-radius: .4rem;
			}
			
		</style>
		
		<script src="/bootstrap.bundle.js"></script>
		<script>
		var currentEditorFile = ''
			
		document.getElementById("command").onkeydown = function(e) {
			if (e.keyCode == 13) {
				execute()
			}
		}

		document.getElementById("editor").onkeydown = function(e) {
			if (e.keyCode == 9 || e.which == 9) {
				e.preventDefault()
				var s = this.selectionStart
				this.value = this.value.substring(0, this.selectionStart) + 
								"\t" +
								this.value.substring(this.selectionEnd)
				this.selectionEnd = s + 1
			}
		}
		
		function switchTheme() {
			var root = document.querySelector(':root')
			var cs = getComputedStyle(root)
			var current = cs.getPropertyValue('--editor')
			current = current.trim()
			if (current == 'white') {
				root.style.setProperty('--editor',      'black')
				root.style.setProperty('--editor-text', '#eee')
				root.style.setProperty('--editor-line', '#666')
			}
			if (current == 'black') {
				root.style.setProperty('--editor',      'white')
				root.style.setProperty('--editor-text', '#333')
				root.style.setProperty('--editor-line', '#bbb')
			}
		}
		
		async function showFolder() {
			var response = await fetch('/list-folder')
			var plain    = await response.text()
			var data = [ ]
			plain = plain.split('\n')
			for (var i in plain) {
				data.push(plain[i])
			}
			var parent = document.querySelector('#folder-result')
			var target = document.querySelector('#folder-target')
			target.innerText = ''
			for (var i in data) {
				var t = ''
				for (var j = 2; j < data[i].length; j++) {
					if (data[i][j] == '/') {
						t += "'&nbsp;&nbsp;&nbsp;"
					}
				}
				var f = data[i].split('/')
				if (f.length > 1) {
					t += "'--&nbsp;" + f[ f.length - 1 ]
					var s = "<a href='javascript:openFile(" +
								'"' + data[i] + '"' + ")'>"
					s += t + '</a><br/>'
					target.innerHTML += s
				}
			}
			parent.style.zIndex = 10
			parent.style.display = 'block'
		}
		
		function closeFolder() {
			var parent = document.querySelector('#folder-result')
			parent.style.zIndex = -10
			parent.style.display = 'none'
		}
		
		async function openFile(file) {
			var response = await fetch('/read-file?name=' + file)
			var plain    = await response.text()
			document.getElementById('editor').value = plain
			var tree = document.querySelector('#folder-result')
			tree.style.zIndex = -10
			tree.style.display = 'none'
			
			var command = document.querySelector('#command-result')
			command.style.zIndex = -10
			command.style.display = 'none'
			
			currentEditorFile = file
			var command = document.getElementById('command')
			command.placeholder = file
		}
		
		async function saveFile() {
			if (currentEditorFile == '') {
				console.log('Empty File')
				return
			}
			
			var editor = document.querySelector('#editor')
			var h = { 'Content-Type': 'application/x-www-form-urlencoded' }
			var detail = {  method: 'POST',
							headers: h,
							body:  'name=' + 
									currentEditorFile + 
									'&text=' + 
									encodeURIComponent(editor.value)
							}
			var response = await fetch('/write-file', detail)
			var plain = await response.text()
			console.log(plain)
		}
		
		function closeFile() {
			currentEditorFile = ''
			var editor = document.querySelector('#editor')
			editor.value = ''
		}
		
		async function execute(command) {
			var element = document.querySelector('#command')
			command = encodeURIComponent(element.value)
			var h = { 'Content-Type': 'application/x-www-form-urlencoded' }
			var detail = {  method: 'POST',
							headers: h,
							body:  'command=' + command }
			var response = await fetch('/execute', detail)
			var plain    = await response.text()
			var result   = document.querySelector('#command-result')
			var element  = document.querySelector
								('#command-result .monospace')
								
			plain = plain.replace(/âââ /g, "'-- ")
			plain = plain.replace(/âÂ Â  /g,   "    ")
			plain = plain.replace(/âââ /g, "'-- ")
			plain = plain.replace(/\n/g, '<br/>')
			plain = plain.replaceAll(' ', '&nbsp;')
			
			element.innerHTML = '<code>' + plain + '</code>'
			result.style.zIndex = 10
			result.style.display = 'block'
		}
		
		function clearResult() {
			var result   = document.querySelector('#command-result')
			var element  = document.querySelector
								('#command-result .monospace')
			element.innerText = ''
			result.style.zIndex = -10
			result.style.display = 'none'
		}
		
		async function runJava() {
			var editor = document.querySelector('#editor')
			var h = { 'Content-Type': 'application/x-www-form-urlencoded' }
			var detail = {  method: 'POST',
							headers: h,
							body:  'text=' + encodeURIComponent(editor.value)
							}
			var response = await fetch('/run-java', detail)
			var plain = await response.text()
			var result   = document.querySelector('#command-result')
			var element  = document.querySelector
								('#command-result .monospace')
			plain = plain.replaceAll(' ', '&nbsp;')
			plain = plain.replace(/\n/g, '<br/>')
			element.innerHTML = '<code>' + plain + '</code>'
			result.style.zIndex = 10
			result.style.display = 'block'
		}
		
		async function runC() {
			var editor = document.querySelector('#editor')
			var h = { 'Content-Type': 'application/x-www-form-urlencoded' }
			var detail = {  method: 'POST',
							headers: h,
							body:  'text=' + encodeURIComponent(editor.value)
							}
			var response = await fetch('/run-c', detail)
			var plain = await response.text()
			var result   = document.querySelector('#command-result')
			var element  = document.querySelector
								('#command-result .monospace')
			plain = plain.replaceAll(' ', '&nbsp;')
			plain = plain.replace(/\n/g, '<br/>')
			element.innerHTML = '<code>' + plain + '</code>'
			result.style.zIndex = 10
			result.style.display = 'block'
		}
		
		function runJavaScript() {
			var original = console.log
			console.log = write
			var editor = document.querySelector('#editor')
			try {
				eval(editor.value)
			} catch (error) {
				write(error.name + ": " + error.message)
			}
			console.log = original
			
			var result   = document.querySelector('#command-result')
			var element  = document.querySelector
								('#command-result .monospace')
			var plain = buffer
			buffer = ''
			plain = plain.replaceAll(' ', '&nbsp;')
			plain = plain.replace(/\n/g, '<br/>')
			element.innerHTML = '<code>' + plain + '</code>'
			result.style.zIndex = 10
			result.style.display = 'block'
		}
		
		var buffer = ''
		function write(x) {
			buffer += x + '\n'
		}
		
		</script>
		
		<script>
			listProject()
			var date = new Date()
			if (date.getHours() >= 18 || date.getHours() < 6) {
				switchTheme()
			}
			
			async function listProject() {
				var response = await fetch("/list-project")
				var data     = await response.text()
				var result   = data.trim().split("\n")
				var menu     = ''
									
				for (var i in result) {
					menu += "<li><a class='dropdown-item' " +
							"href='javascript:showSpecification(" +
							'"' + result[i] + '")' + "'>" +
							result[i] + "</a>"
				}
					menu += "<li><a class='dropdown-item' " +
							"href='javascript:listProject()'>" +
							"Refresh</a>"
				
				var main = document.querySelector('#project-menu')
				main.innerHTML = menu
				
				/*
				var html     = ''
				for (var i in result) {
					html += "<a href='javascript:showSpecification(" +
							'"' + result[i] + '")' + "'>" +
							result[i] + "</a><br/>\n"
				}
				
				var detail = document.querySelector('#web-view-detail')
				detail.innerHTML = html
				var view = document.querySelector('#web-view')
				view.style.display = 'block' 
				*/
			}
			
			async function showSpecification(project) {
				var response = await fetch("/read-file?name=" +
										"./" + project + "/minimal/" +
										"specification.html")
				var data = await response.text()
			   
				var detail = document.querySelector('#web-view-detail')
				data = '<h1>' + project + '</h1>' + data
				detail.innerHTML = data
				var view = document.querySelector('#web-view')
				view.style.display = 'block'
			}
			function closeView() {
				var view = document.querySelector('#web-view')
				view.style.display = 'none'
			}
		</script>
		<style>
			#web-view {
				display: none;
				background: var(--editor);
				color: var(--editor-text);
				position: absolute;
				width: 100%;
				min-height: calc(100vh - 3.45rem);
				margin-top: .5rem;
				padding-top: 0.5rem;
			}
			
			#web-view-detail {
				
			}
			
			story {
				display: block;
				background: var(--editor);
				border: 1px solid var(--editor-line);
				margin-bottom: 1rem;
				padding: .5rem 1rem;
				border-radius: 1rem;
				border-left: 2rem solid #789;
			}
			
			story[priority=high] {
				border-left: 2rem solid #c33;
			}
			
			story[priority=medium] {
				border-left: 2rem solid gold;
			}
			
			story[priority=low] {
				border-left: 2rem solid green;
			}
			
			story title {
				display: block;
			}
			
			story detail {
				margin-top: -1.5rem;
				display: block;
				white-space: pre-line;
				font-family: monospace;
				font-size: 1.25rem;
				tab-size: 4;
			}
			
			story status {
				display: inline-block;
				color: var(--editor-text);
				opacity: .85;
				float: right;
			}
			
			story staff {
				display: inline-block;
				color: var(--editor-text);
				opacity: .85;
				margin-right: 2rem;
			}
			
		</style>
	</body>
</html>
