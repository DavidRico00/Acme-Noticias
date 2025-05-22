function eliminarArticulo(contextPath, articuloId) {
    if (!confirm("¿Estás seguro de que deseas eliminar este artículo?")) {
        return;
    }
    fetch(`${contextPath}/articulo/eliminar?id=${articuloId}`, {
        method: 'POST'
    }).then(response => {
        if(response.ok){
            location.reload();
        }else{
            alert("Error al eliminar el articulo");
        }
    });
}

function activarBotones(){
    document.getElementById("email").disabled = false;
    document.getElementById("dni").disabled = false;
    document.getElementById("editarPerfil").style.display = "none";
    document.getElementById("cancelarPerfil").style.display = "inline";
    document.getElementById("guardarPerfil").style.display = "inline";
    document.getElementById("profileimg").style.display = "inline";
}

function desactivarBotones(){
    location.reload();
}
