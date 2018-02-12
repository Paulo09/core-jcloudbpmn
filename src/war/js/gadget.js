function pageLoad(){

		// Vinculo a nossa fun��o as a��es de Dock e Undock
		System.Gadget.onDock = dockChanged;		
		System.Gadget.onUndock = dockChanged;
}

//Fa�o minha fun��o � vinculada ao OnLoad da pagina
window.attachEvent("onload", pageLoad);


//
// Essa fun��o controlar� a a��o de dock/Undock do nosso gadget
//
function dockChanged()
{
	// Se estiver minimizado
	if (System.Gadget.docked)
	{
		//Muda o tamanho do body
		document.body.style.height = "130px";
		document.body.style.width = "650px";
		// Muda a visibilidade das divs
		document.getElementById("dvDocked").style.display = '';
		document.getElementById("dvUndocked").style.display = 'none';
	}
	else
	{
		//Muda o tamanho do body
		document.body.style.height = "90px";
		document.body.style.width = "90px";
		// Muda a visibilidade das divs
		document.getElementById("dvDocked").style.display = 'none';
		document.getElementById("dvUndocked").style.display = 'none';
	}
}