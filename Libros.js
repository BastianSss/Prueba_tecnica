document.addEventListener('DOMContentLoaded', () => {
    const form = document.getElementById('form-libro');
    const tablaLibros = document.getElementById('tabla-libros').getElementsByTagName('tbody')[0];

    // Cargar libros
    fetch('http://localhost:3000/api/libros')
        .then(response => response.json())
        .then(libros => {
            libros.forEach(libro => agregarFilaLibro(libro));
        });

    form.addEventListener('submit', (event) => {
        event.preventDefault();
        const autor = document.getElementById('autor').value;
        const fecha_nacimiento = document.getElementById('fecha-nacimiento').value;
        const lugar_nacimiento = document.getElementById('lugar-nacimiento').value;
        const nombre_libro = document.getElementById('nombre-libro').value;
        const fecha_publicacion = document.getElementById('fecha-publicacion').value;

        fetch('http://localhost:3000/api/libros', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ autor, fecha_nacimiento, lugar_nacimiento, nombre_libro, fecha_publicacion })
        })
            .then(response => response.json())
            .then(libro => {
                agregarFilaLibro(libro);
                form.reset();
            });
    });

    function agregarFilaLibro(libro) {
        const fila = tablaLibros.insertRow();
        fila.insertCell(0).textContent = libro.autor;
        fila.insertCell(1).textContent = libro.fecha_nacimiento;
        fila.insertCell(2).textContent = libro.lugar_nacimiento;
        fila.insertCell(3).textContent = libro.nombre_libro;
        fila.insertCell(4).textContent = libro.fecha_publicacion;
        const acciones = fila.insertCell(5);
        const botonEliminar = document.createElement('button');
        botonEliminar.textContent = 'Eliminar';
        botonEliminar.addEventListener('click', () => {
            fetch(`http://localhost:3000/api/libros/${libro.id}`, {
                method: 'DELETE'
            })
                .then(response => {
                    if (response.ok) {
                        tablaLibros.deleteRow(fila.rowIndex - 1);
                    }
                });
        });
        acciones.appendChild(botonEliminar);
    }
});
