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
