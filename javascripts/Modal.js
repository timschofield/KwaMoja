function ShowModal(linkURL) {
	document.getElementById("modal").style.borderWidth = "4px";
	document.getElementById("modal").style.padding = "6px";
	document.getElementById("modal").style.width = "96%";
	GetContent('modal', linkURL);
}
function CloseModal() {
	document.getElementById("modal").style.padding = "0px";
	document.getElementById("modal").style.width = "0px";
	document.getElementById("modal").style.borderWidth = "0px";
	document.getElementById('modal').innerHTML='';
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
					t.onclick =  function () {Redirect(this); return false};
				}
			}
		}
		var e = document.getElementsByTagName("input");
		for (i = 0; i < e.length; i++) {
			var t = e[i];
			if (t.getAttribute("type")=='submit') {
				t.onclick = function () {SubmitThisForm(t.form,'modal'); return false};
			}
		}
	}
	ShowMessages();
}

function GetContent(id, section) {
	if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp=new XMLHttpRequest();
	} else {// code for IE6, IE5
		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange=function() {
		if (xmlhttp.readyState==4 && xmlhttp.status==200) {
//			data=JSON.parse(xmlhttp.responseText);
//			modalHeader.innerHTML=document.getElementById('title').innerHTML;
			document.getElementById(id).innerHTML=xmlhttp.responseText;
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

function SubmitThisForm(FormName, Element) {
	Target=FormName.action;
	var PostData='';
	for(var i=0,fLen=FormName.length;i<fLen;i++){
		if(FormName.elements[i].type=='checkbox' && !FormName.elements[i].checked) {
			FormName.elements[i].value=null;
		}
		PostData=PostData+FormName.elements[i].name+'='+FormName.elements[i].value+'&';
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
	n=document.getElementsByName('success');
	if (n.length > 0)
	for (i = 0; i < n.length; i++) {
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
	for (i = w; i < n.length+w-1; i++) {
		divMessage[i] = document.createElement("div");
		divMessage[i].className = "info";
		divMessage[i].style.top = (50+140*i)+"px";
		divMessage[i].innerHTML=n[i].innerHTML;
		document.getElementById('modal').appendChild(divMessage[i]);
		setTimeout(FadeOut, 2000, divMessage[i]);
	}
	w=i;
	n=document.getElementsByName('warn');
	if (n.length > 0)
	for (i = w; i < n.length+w-1; i++) {
		divMessage[i] = document.createElement("div");
		divMessage[i].className = "warn";
		divMessage[i].style.top = (50+140*i)+"px";
		divMessage[i].innerHTML=n[i].innerHTML;
		document.getElementById('modal').appendChild(divMessage[i]);
		setTimeout(FadeOut, 2000, divMessage[i]);
	}
	w=i;
	n=document.getElementsByName('error');
	if (n.length > 0)
	for (i = w; i < n.length+w-1; i++) {
		divMessage[i] = document.createElement("div");
		divMessage[i].className = "error";
		divMessage[i].style.top = (50+140*i)+"px";
		divMessage[i].innerHTML=n[i].innerHTML;
		document.getElementById('modal').appendChild(divMessage[i]);
		setTimeout(FadeOut, 2000, divMessage[i]);
	}
}