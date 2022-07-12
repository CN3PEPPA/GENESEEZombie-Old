--Obgrigado a todos por comprarem o studio de tatuagens, alguns clientes me reclamaram que ao sair da loja de roupas por ex as tataugens sumiam,
--para arrumar esse bug coloque a seguinte linha no código seguindo o tutorial

--Caso o arquivo seja client bote a seguinte linha abaixo de

	vRP.setCustomization...

--Linha a ser colocada

	TriggerServerEvent('dpn_tattoo:setPedClient')

--Caso o arquivo seja server coloque a seguinte linha abaixo de

	vRPclient._setCustomization...

--Linha a ser colocada

	TriggerEvent('dpn_tattoo:setPedServer',source)


--Caso achem mais bugs relatam em algum ticket em 

--https://discord.gg/KxKMTKU
