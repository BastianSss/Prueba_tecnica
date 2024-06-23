document.addEventListener('DOMContentLoaded', () => {
    const form = document.getElementById('form-estudiante');
    const tablaEstudiantes = document.getElementById('tabla-estudiantes').getElementsByTagName('tbody')[0];

    // Cargar estudiantes
    fetch('http://localhost:3000/api/estudiantes')
        .then(response => response.json())
        .then(estudiantes => {
            estudiantes.forEach(estudiante => agregarFilaEstudiante(estudiante));
        });
});

form.addEventListener('submit', (event) => {
    event.preventDefault();
    const nombre = document.getElementById('nombre').value;
    const documento = document.getElementById('documento').value;
    const programa = document.getElementById('programa').value;

    fetch('http://localhost:3000/api/estudiantes', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ nombre, documento, programa })
    })
    .then(response => response.json())
    .then(estudiante => {
        agregarFilaEstudiante(estudiante);
        form.reset();
    });
});

function agregarFilaEstudiante(estudiante) {
    const fila = tablaEstudiantes.insertRow();
    fila.insertCell(0).textContent = estudiante.nombre;
    fila.insertCell(1).textContent = estudiante.documento;
    fila.insertCell(2).textContent = estudiante.programa;

    // Agregar botón de eliminar
    const acciones = fila.insertCell(3);
    const botonEliminar = document.createElement('button');
    botonEliminar.textContent = 'Eliminar';
    botonEliminar.addEventListener('click', () => {
        fetch(`http://localhost:3000/api/estudiantes/${estudiante.id}`, {
            method: 'DELETE'
        })
        .then(response => {
            if (response.ok) {
                tablaEstudiantes.deleteRow(fila.rowIndex - 1);
            }
        });
    });
    acciones.appendChild(botonEliminar);
}
