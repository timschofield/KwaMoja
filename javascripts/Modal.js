let CurrentPage = '';
function ShowModal(linkURL) {
	CurrentPage=linkURL;
	if (document.getElementById("mask").style.display!="block") {
		document.getElementById("mask").style.display="block";
		document.getElementById("ModuleList").style.display="none";
	}
	document.body.style.overflow="hidden";
	document.getElementById("modal").style.borderWidth = "4px";
	document.getElementById("modal").style.padding = "6px";
	document.getElementById("modal").style.width = "96%";
	GetContent('modal', linkURL);
}
function CloseModal() {
	if (CurrentPage.toString().substring(0,8) != "Menu.php") {
		ShowModal("Menu.php");
		return;
	}
	document.body.style.overflow="auto";
	document.getElementById("modal").style.padding = "0px";
	document.getElementById("modal").style.width = "0px";
	document.getElementById("modal").style.borderWidth = "0px";
	document.getElementById('modal').innerHTML='';
	if (document.getElementById("mask").style.display=="block") {
		document.getElementById("ModuleList").style.display="block";
		document.getElementById("mask").style.display="none";
	}
}

function Redirect(e) {
	GetContent('modal', e.getAttribute("href").replace(/^.*[\\\/]/, ''));
}

function OverRideClicks() {
	if (document.getElementsByTagName) {
		var e = document.getElementsByTagName("a");
		for (i = 0; i < e.length; i++) {
			var t = e[i];
			if (t.getAttribute("href")!="#" && t.id!="exit" && t.id!="MainMenu") {
				handler=t.getAttribute("onclick");
				t.target = "_blank"
				if (handler!=null && handler.substring(7,18)=='MakeConfirm') {
					var conf=Function(handler+';return false');
					t.onclick =  function () {conf(); Redirect(this); return false};
				} else {
					var conf=Function(handler+';');
					t.onclick =  function () {conf(); Redirect(this); return false};
				}
			}
		}
		var e = document.getElementsByTagName("input");
		for (i = 0; i < e.length; i++) {
			var t = e[i];
			if (t.getAttribute("type")=='submit') {
				t.onclick = function () {SubmitThisForm(this,'modal'); return false};
			}
		}
	}
	ShowMessages();
}

function GetContent(id, section, BookMark="") {
	if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp=new XMLHttpRequest();
	} else {// code for IE6, IE5
		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	}

	xmlhttp.onreadystatechange=function() {
		if (xmlhttp.readyState==4 && xmlhttp.status==200) {
			document.getElementById(id).innerHTML=xmlhttp.responseText;
			if (id.toString()=="help-content") {
				var ViewTopic = section.toString().substring(17, section.toString().length-5);
				document.getElementById('help-header').innerHTML=document.getElementById('help-header').innerHTML+document.getElementById(ViewTopic).innerHTML+" - "+document.getElementById(BookMark).innerHTML;
				var help_anchor = document.getElementById(BookMark);
				help_anchor.scrollIntoView({behavior: "smooth"});
			}
			OverRideClicks();
			SetSortingEvent();
		}
	}
	xmlhttp.open("GET",section,true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.setRequestHeader("Cache-Control","no-store, no-cache, must-revalidate");
	xmlhttp.setRequestHeader("Pragma","no-cache");
	xmlhttp.send();
	return false;
};

function SubmitThisForm(Button, Element) {
	FormName =Button.form;
	if (FormName.name=="UserSettings") {
		document.getElementById('StyleSheet').setAttribute("href", "css/" + document.getElementById('Theme').value + "/styles.css");
	}
	Target=FormName.action;
	var PostData='';
	for(var i=0,fLen=FormName.length;i<fLen;i++){
		if(FormName.elements[i].type=='checkbox' && !FormName.elements[i].checked) {
			FormName.elements[i].value=null;
		}
		if(FormName.elements[i].type=='submit' && (FormName.elements[i].name != Button.name)) {
			FormName.elements[i].value=null;
		} else {
			PostData=PostData+FormName.elements[i].name+'='+FormName.elements[i].value+'&';
		}
	}
	if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp=new XMLHttpRequest();
	} else {// code for IE6, IE5
		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange=function() {
		if (xmlhttp.readyState==4 && xmlhttp.status==200) {
			document.getElementById('modal').innerHTML=xmlhttp.responseText;
			OverRideClicks();
		}
	}
	xmlhttp.open("POST",Target,true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.setRequestHeader("Cache-Control","no-store, no-cache, must-revalidate");
	xmlhttp.setRequestHeader("Pragma","no-cache");
	xmlhttp.send(PostData);
	return false;
}
function FadeOut(divMessage) {
	divMessage.style.opacity=0;
}
function ShowMessages() {
	var divMessage = new Array();
	n=document.getElementsByName('error');
	w=0;
	i=0;
	if (n.length > 0)
	for (i = w; i < n.length; i++) {
		divMessage[i] = document.createElement("div");
		divMessage[i].className = "error";
		divMessage[i].style.top = (50+100*i)+"px";
		divMessage[i].innerHTML=n[i].innerHTML;
		document.getElementById('modal').appendChild(divMessage[i]);
		setTimeout(FadeOut, 2000, divMessage[i]);
	}
	w=i;
	n=document.getElementsByName('success');
	if (n.length > 0)
	for (i = w; i < (n.length+w); i++) {
		divMessage[i] = document.createElement("div");
		divMessage[i].className = "success";
		divMessage[i].style.top = (50+100*i)+"px";
		divMessage[i].innerHTML=n[i].innerHTML;
		document.getElementById('modal').appendChild(divMessage[i]);
		setTimeout(FadeOut, 2000, divMessage[i]);
	}
	w=i;
	n=document.getElementsByName('info');
	if (n.length > 0)
	for (i = w; i < n.length+w; i++) {
		divMessage[i] = document.createElement("div");
		divMessage[i].className = "info";
		divMessage[i].style.top = (50+100*i)+"px";
		divMessage[i].innerHTML=n[i].innerHTML;
		document.getElementById('modal').appendChild(divMessage[i]);
		setTimeout(FadeOut, 2000, divMessage[i]);
	}
	w=i;
	n=document.getElementsByName('warn');
	if (n.length > 0)
	for (i = w; i < n.length+w; i++) {
		divMessage[i] = document.createElement("div");
		divMessage[i].className = "warn";
		divMessage[i].style.top = (50+100*i)+"px";
		divMessage[i].innerHTML=n[i].innerHTML;
		document.getElementById('modal').appendChild(divMessage[i]);
		setTimeout(FadeOut, 2000, divMessage[i]);
	}
}
function ShowModules() {
	if (document.getElementById("ModuleList").style.height=="80%") {

		document.getElementById("mask").style.display="none";
		document.getElementById("ModuleList").style.height="0px";
		document.getElementById("ModuleList").style.padding="0%";
		document.getElementById("TopLogo").style.display="none";
		var n = document.getElementsByClassName("Module");
		for (i = 0; i < (n.length); i++) {
			n[i].style.display='none';
			n[i].style.width='0%';
		}
	} else {
		document.getElementById("mask").style.display="block";
		document.getElementById("ModuleList").style.height="80%";
		document.getElementById("ModuleList").style.padding="1%";
		document.getElementById("TopLogo").style.display="block";
		var n = document.getElementsByClassName("Module");
		for (i = 0; i < (n.length); i++) {
			n[i].style.display='block';
			n[i].style.width='90%';
		}
	}
}
function ShowHelp(ViewTopic, BookMark) {
	document.getElementById("help-bubble").style.display="block";
	document.getElementById('help-header').innerHTML='<div id="help_exit" class="close_button" onclick="CloseHelp()" title="Close this window">X</div>';
	GetContent("help-content", "doc/Manual/Manual"+ViewTopic+".html", BookMark);
}
function CloseHelp() {
	document.getElementById("help-bubble").style.display="none";
}
