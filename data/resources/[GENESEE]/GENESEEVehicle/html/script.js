var timeout, opened, model, vehclass, parts, plate, repair, mileage, workshop, Parts = {},
	partType = "",
	allparts = {};

function closeMenu() {
	$.post("https://GENESEEVehicle/close", JSON.stringify({})), $("#main_container").fadeOut(400), timeout = setTimeout(function () {
		$("#main_container").html(""), $("#main_container").fadeIn()
	}, 400)
}

function replacePart(e) {
	var a = e.dataset.part;
	$.post("https://GENESEEVehicle/replace", JSON.stringify({
		part: a,
		parttype: partType
	})), closeMenu()
}

function repairPart() {
	$.post("https://GENESEEVehicle/repair", JSON.stringify({
		parttype: partType
	})), closeMenu()
}

function removePart() {
	$.post("https://GENESEEVehicle/removePart", JSON.stringify({
		parttype: partType
	})), closeMenu()
}

function cancelRepair() {
	$.post("https://GENESEEVehicle/cancelrepair", JSON.stringify({})), closeMenu()
}

function installPart(e) {
	var a = e.dataset.part;
	$.post("https://GENESEEVehicle/install", JSON.stringify({
		part: a,
		parttype: partType
	})), closeMenu()
}

function openInstallPart() {
	$("#main_container").html("");
	var e = '<div class="clearfix slide-left borderbox" id="page">\x3c!-- column --\x3e   <div class="clearfix colelem " onclick="openVehicleMenu()" id="back"><i class="fas fa-chevron-circle-left fa-lg"></i></div>   <div class="clearfix colelem " id="pu378-4">\x3c!-- group --\x3e    <div class="clearfix grpelem" id="u378-4">\x3c!-- content --\x3e     <p>PEÇAS</p>    </div>   </div>   <div class="rounded-corners colelem" id="u392" >\x3c!-- simple frame --\x3e</div>   <div class="clearfix colelem" id="pu126">\x3c!-- group --\x3e';
	for (const [a, i] of Object.entries(allparts[partType])) e = e + '    <div class="gradient  grpelem part" onclick="installPart(this)" data-part="' + a + '" id="u126">\x3c!-- column --\x3e     <div class="colelem" id="u247" style="background: url(img/' + a + '.png) no-repeat center; background-size: 90%; " data-sizePolicy="fixed" data-pintopage="page_fixedRight">\x3c!-- rasterized frame --\x3e</div>     <div class="clearfix colelem" id="u148-4" data-sizePolicy="fixed" data-pintopage="page_fixedRight">\x3c!-- content --\x3e      <p>' + i.label + "</p>     </div>    </div>";
	e += '   </div>   <div class="verticalspacer" data-offset-top="0" data-content-above-spacer="756" data-content-below-spacer="324" data-sizePolicy="fixed" data-pintopage="page_fixedLeft"></div>  </div>', $("#main_container").append(e)
}

function openRepairParts() {
	$("#main_container").html("");
	var e = '<div class="clearfix slide-left borderbox" id="page">\x3c!-- column --\x3e   <div class="clearfix colelem " onclick="openVehicleMenu()" id="back"><i class="fas fa-chevron-circle-left fa-lg"></i></div>   <div class="clearfix colelem " id="pu378-4">\x3c!-- group --\x3e    <div class="clearfix grpelem" id="u378-4">\x3c!-- content --\x3e     <p>CONS. PEÇAS</p>    </div>   </div>   <div class="rounded-corners colelem" id="u392" >\x3c!-- simple frame --\x3e</div>   <div class="clearfix colelem" id="pu126">\x3c!-- group --\x3e';
	for (const [a, i] of Object.entries(allparts[partType][Parts[partType].type].repair)) e = e + '    <div class="gradient  grpelem part" data-part="' + a + '" id="u126">\x3c!-- column --\x3e     <div class="colelem" id="u247" style="background: url(https://arcadiuscity.com/sources/vrp_images/' + a + '.png) no-repeat center; background-size: 90%; " data-sizePolicy="fixed" data-pintopage="page_fixedRight">\x3c!-- rasterized frame --\x3e</div>     <div class="clearfix colelem" id="u148-4" data-sizePolicy="fixed" data-pintopage="page_fixedRight">\x3c!-- content --\x3e      <p> ' + i.amount + " x " + i.label + "</p>     </div>    </div>";
	e += '   </div>   <div class="verticalspacer" data-offset-top="0" data-content-above-spacer="756" data-content-below-spacer="324" data-sizePolicy="fixed" data-pintopage="page_fixedLeft"></div>  </div>', $("#main_container").append(e)
}

function openReplaceParts() {
	$("#main_container").html("");
	var e = '<div class="clearfix slide-left borderbox" id="page">\x3c!-- column --\x3e   <div class="clearfix colelem " onclick="openVehicleMenu()" id="back"><i class="fas fa-chevron-circle-left fa-lg"></i></div>   <div class="clearfix colelem " id="pu378-4">\x3c!-- group --\x3e    <div class="clearfix grpelem" id="u378-4">\x3c!-- content --\x3e     <p>PEÇAS</p>    </div>   </div>   <div class="rounded-corners colelem" id="u392" >\x3c!-- simple frame --\x3e</div>   <div class="clearfix colelem" id="pu126">\x3c!-- group --\x3e';
	for (const [a, i] of Object.entries(allparts[partType])) 0 != allparts[partType][a].usability.exclusive.length && !allparts[partType][a].usability.exclusive.includes(model) || 0 != allparts[partType][a].usability.vehicletypes.length && !allparts[partType][a].usability.vehicletypes.includes(vehclass) || (e = e + '    <div class="gradient  grpelem part" onclick="replacePart(this)" data-part="' + a + '" id="u126">\x3c!-- column --\x3e     <div class="colelem" id="u247" style="background: url(https://arcadiuscity.com/sources/vrp_images/' + a + '.png) no-repeat center; background-size: 90%; " data-sizePolicy="fixed" data-pintopage="page_fixedRight">\x3c!-- rasterized frame --\x3e</div>     <div class="clearfix colelem" id="u148-4" data-sizePolicy="fixed" data-pintopage="page_fixedRight">\x3c!-- content --\x3e      <p>' + i.label + "</p>     </div>    </div>");
	e += '   </div>   <div class="verticalspacer" data-offset-top="0" data-content-above-spacer="756" data-content-below-spacer="324" data-sizePolicy="fixed" data-pintopage="page_fixedLeft"></div>  </div>', $("#main_container").append(e)
}

function openVehicleMenu() {
	$("#main_container").html("");
	var e = !1,
		a = !1;
	Parts = parts;
	var i = '<div class="clearfix slide-left borderbox" id="page">\x3c!-- column --\x3e';
	repair && (i += '<div id="repairMode"><div id="repairText">MODO DE REPARO</div><div id="repairButton" class="ripple" onclick="cancelRepair()">CANCELAR</div> </div>'), i = i + '   <div class="clearfix colelem " id="pu378-4">\x3c!-- group --\x3e    <div class="clearfix grpelem" id="u378-4">\x3c!-- content --\x3e     <p>' + mileage + ' MILHAS</p>    </div>    <div class="clearfix grpelem" id="u389-4">\x3c!-- content --\x3e     <p>' + plate + "</p>     <p>" + vehiclemodel + '</p>    </div>   </div>   <div class="rounded-corners colelem" id="u392" >\x3c!-- simple frame --\x3e</div>   <div class="clearfix colelem" id="pu126">\x3c!-- group --\x3e';
	for (const [l, c] of Object.entries(parts)) {
		var t = 1.25 * c.health;
		i = i + '    <div class="gradient  grpelem box" data-type="' + l + '" id="u126">\x3c!-- column --\x3e     <div class="colelem" id="u247" style="background: url(https://arcadiuscity.com/sources/vrp_images/' + c.type + '.png) no-repeat center; background-size: 90%; " data-sizePolicy="fixed" data-pintopage="page_fixedRight">\x3c!-- rasterized frame --\x3e</div>     <div class="clearfix colelem" id="u148-4" data-sizePolicy="fixed" data-pintopage="page_fixedRight">\x3c!-- content --\x3e      <p>' + c.label + '</p>     </div>     <div class="rgba-background clearfix colelem" id="u141">\x3c!-- group --\x3e      <div class="rgba-background grpelem" id="u144" style="width: ' + t + 'px" data-sizePolicy="fixed" data-pintopage="page_fixedRight">\x3c!-- simple frame --\x3e</div>     </div>    </div>', "nitro" == l ? e = !0 : "turbo" == l && (a = !0)
	}!a && workshop && (i += '    <div class="gradient grpelem box" data-type="uninstalled" data-uninstalled="turbo" style="opacity: 0.7;" id="u126">\x3c!-- column --\x3e     <div class="colelem" id="u247" data-sizePolicy="fixed" data-pintopage="page_fixedRight">\x3c!-- rasterized frame --\x3e</div>    </div>'), !e && workshop && (i += '    <div class="gradient grpelem box" data-type="uninstalled" data-uninstalled="nitro" style="opacity: 0.7;" id="u126">\x3c!-- column --\x3e     <div class="colelem" id="u247" data-sizePolicy="fixed" data-pintopage="page_fixedRight">\x3c!-- rasterized frame --\x3e</div>    </div>'), i += '   </div>   <div class="verticalspacer" data-offset-top="0" data-content-above-spacer="756" data-content-below-spacer="324" data-sizePolicy="fixed" data-pintopage="page_fixedLeft"></div>  </div>', $("#main_container").append(i)
}

function openGauge(e, a) {
	$("#gauges").append('<div class="clearfix colelem slide-left" id="gauge_location">\x3c!-- group --\x3e    <div class="rounded-corners" id="u108">\x3c!-- group --\x3e<div id="u109">NOS</div><div id="u110"></div>    </div>    <div class="clip_frame grpelem" id="u120">\x3c!-- image --\x3e     <img class="block" id="u120_img" src="img/lowoil.png" alt="" data-heightwidthratio="0.8" data-image-width="45" data-image-height="36"/>    </div>    <div class="clip_frame grpelem" id="u130">\x3c!-- image --\x3e     <img class="block" id="u130_img" src="img/checkengine.png" alt="" data-heightwidthratio="1" data-image-width="36" data-image-height="36"/>    </div>    <div class="rounded-corners clearfix grpelem" id="u107">\x3c!-- group --\x3e     <div class="clearfix grpelem" id="u111-4">\x3c!-- content --\x3e    00003485.0     </div>    </div>   </div>'), $("#gauge_location").css("bottom", e + "vh").css("right", a + "vw")
}

function pad(e, a) {
	var i = "000000000" + e;
	return i.substr(i.length - a)
}

function playClickSound() {
	var e = document.getElementById("clickaudio");
	e.volume = .05, e.play()
}

$(document).keyup(function (e) {
	27 === e.keyCode && closeMenu()
}), window.onclick = function (e) {
	null != opened && (opened.style.display = "none", opened.remove(), opened = null)
}, window.oncontextmenu = function (e) {
	null != opened && (opened.style.display = "none", opened.remove(), opened = null);
	var a = $(e.target).parents(".box")[0];
	if (null != a) {
		var i = '<div id="dropdown" class="dropdown-content">';
		"uninstalled" == (partType = a.dataset.type) ? (partType = a.dataset.uninstalled, i += '    <a onclick="openInstallPart()">Instalar</a>') : (Parts[partType].health > 0 && null != allparts[partType][Parts[partType].type].repair && (i += '    <a onclick="repairPart()">Consertar</a>', i += '    <a onclick="openRepairParts()">Verificar</a>'), i += '    <a onclick="openReplaceParts()">Substituir</a>'), "turbo" != partType && "nitro" != partType || (i += '    <a onclick="removePart()">Remover</a>'), i += "  </div>", $("#main_container").append(i);
		var t = document.getElementById("dropdown");
		t.style.display = "block";
		var l = a.getBoundingClientRect();
		t.style.top = l.top + (l.bottom - l.top), t.style.left = l.left, t.classList.add("active"), opened = t
	}
}, window.addEventListener("message", function (e) {
	var a = e.data;
	"showinfo" == a.type && openGauge(a.bottom, a.right), "hideinfo" == a.type && ($("#gauges").fadeOut(400), timeout = setTimeout(function () {
		$("#gauges").html(""), $("#gauges").fadeIn()
	}, 400)), "info" == a.type && ($("#u111-4").text(pad(a.mileage, 9)), a.nitro > 0 ? ($("#u108").css("display", "inline"), $("#u110").css("width", a.nitro)) : $("#u108").css("display", "none"), a.check ? $("#u130_img").attr("src", "img/checkengine_light.png") : $("#u130_img").attr("src", "img/checkengine.png"), a.oil ? $("#u120_img").attr("src", "img/lowoil_light.png") : $("#u120_img").attr("src", "img/lowoil.png")), "open" == a.type && (repair = a.repair, allparts = a.allparts, vehclass = a.vehicleType, vehiclemodel = a.vehiclemodel, model = a.model, parts = a.parts, plate = a.plate, mileage = a.mileage, workshop = a.workshop, openVehicleMenu())
});