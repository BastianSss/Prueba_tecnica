document.addEventListener('DOMContentLoaded', () => {
    const form = document.getElementById('form-prestamo');
    const tablaPrestamos = document.getElementById('tabla-prestamos').getElementsByTagName('tbody')[0];
    const selectEstudiante = document.getElementById('estudiante');
    const selectLibro = document.getElementById('libro');

    // Simulamos la carga de datos de estudiantes y libros
    // En una aplicación real se harían peticiones a un servidor para obtener estos datos
    const estudiantes = [
        { nombre: 'Juan Pérez', documento: '123456789', programa: 'Ingeniería' },
        { nombre: 'María García', documento: '987654321', programa: 'Diseño' }
    ];
    const libros = [
        { nombre: 'Don Quijote', autor: 'Miguel de Cervantes' },
        { nombre: 'Cien Años de Soledad', autor: 'Gabriel García Márquez' }
    ];

    estudiantes.forEach(estudiante => {
        const option = document.createElement('option');
        option.value = estudiante.documento;
        option.textContent = `${estudiante.nombre} - ${estudiante.programa}`;
        selectEstudiante.appendChild(option);
    });

    libros.forEach(libro => {
        const option = document.createElement('option');
        option.value = libro.nombre;
        option.textContent = `${libro.nombre} - ${libro.autor}`;
        selectLibro.appendChild(option);
    });

    form.addEventListener('submit', (event) => {
        event.preventDefault();
        const estudiante = selectEstudiante.options[selectEstudiante.selectedIndex].text;
        const libro = selectLibro.options[selectLibro.selectedIndex].text;
        const fechaPrestamo = document.getElementById('fecha-prestamo').value;
        const tiempoDevolucion = document.getElementById('tiempo-devolucion').value;

        // Simulamos el guardado de datos (En una aplicación real se haría una petición a un servidor)
        const fila = tablaPrestamos.insertRow();
        fila.insertCell(0).textContent = estudiante;
        fila.insertCell(1).textContent = libro;
        fila.insertCell(2).textContent = fechaPrestamo;
        fila.insertCell(3).textContent = tiempoDevolucion;
        const acciones = fila.insertCell(4);
        const botonEliminar = document.createElement('button');
        botonEliminar.textContent = 'Eliminar';
        botonEliminar.addEventListener('click', () => {
            tablaPrestamos.deleteRow(fila.rowIndex - 1);
        });
        acciones.appendChild(botonEliminar);

        form.reset();
    });
});
