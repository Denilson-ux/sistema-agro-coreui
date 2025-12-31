/**
 * Sistema Agrícola - CoreUI Laravel
 * JavaScript principal
 */

import './bootstrap';

// Importar SimpleBar para el sidebar scroll
import 'simplebar';
import 'simplebar/dist/simplebar.css';

// Importar CoreUI
import * as coreui from '@coreui/coreui';

// Hacer CoreUI disponible globalmente
window.coreui = coreui;

// Inicializar tooltips y popovers
document.addEventListener('DOMContentLoaded', function () {
    // Tooltips
    const tooltipTriggerList = [].slice.call(
        document.querySelectorAll('[data-coreui-toggle="tooltip"]')
    );
    tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new coreui.Tooltip(tooltipTriggerEl);
    });

    // Popovers
    const popoverTriggerList = [].slice.call(
        document.querySelectorAll('[data-coreui-toggle="popover"]')
    );
    popoverTriggerList.map(function (popoverTriggerEl) {
        return new coreui.Popover(popoverTriggerEl);
    });

    // FIX DEFINITIVO: Ajustar wrapper dinámicamente cuando el sidebar se colapsa
    const sidebar = document.querySelector('.sidebar');
    const wrapper = document.querySelector('.wrapper');
    
    if (sidebar && wrapper) {
        // Función para ajustar el wrapper
        function adjustWrapper() {
            const isNarrow = sidebar.classList.contains('sidebar-narrow');
            
            console.log('Sidebar narrow:', isNarrow); // Debug
            
            if (isNarrow) {
                // Sidebar colapsado - wrapper pegado a la izquierda
                wrapper.style.paddingLeft = '56px';
                console.log('Aplicando padding: 56px');
            } else {
                // Sidebar abierto - wrapper con espacio completo
                wrapper.style.paddingLeft = '256px';
                console.log('Aplicando padding: 256px');
            }
        }
        
        // Observar cambios en las clases del sidebar
        const observer = new MutationObserver(function(mutations) {
            mutations.forEach(function(mutation) {
                if (mutation.attributeName === 'class') {
                    console.log('Clase cambiada, ajustando wrapper');
                    adjustWrapper();
                }
            });
        });
        
        observer.observe(sidebar, {
            attributes: true,
            attributeFilter: ['class']
        });
        
        // Ajustar al cargar la página
        adjustWrapper();
        
        // También escuchar el evento de CoreUI
        document.addEventListener('sidebar-toggle', function() {
            console.log('Evento sidebar-toggle detectado');
            setTimeout(adjustWrapper, 50);
        });
    } else {
        console.error('Sidebar o wrapper no encontrados');
    }
});

console.log('Sistema Agrícola CoreUI Laravel - Cargado ✅');
