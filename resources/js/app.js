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

    // FIX: Ajustar wrapper dinámicamente cuando el sidebar se colapsa
    const sidebar = document.querySelector('.sidebar');
    const wrapper = document.querySelector('.wrapper');
    
    if (sidebar && wrapper) {
        // Función para ajustar el wrapper
        function adjustWrapper() {
            const isNarrow = sidebar.classList.contains('sidebar-narrow');
            
            if (isNarrow) {
                // Sidebar colapsado - wrapper con margen pequeño
                wrapper.style.marginLeft = '56px';
            } else {
                // Sidebar abierto - wrapper con margen normal
                wrapper.style.marginLeft = '256px';
            }
        }
        
        // Observar cambios en las clases del sidebar
        const observer = new MutationObserver(function() {
            adjustWrapper();
        });
        
        observer.observe(sidebar, {
            attributes: true,
            attributeFilter: ['class']
        });
        
        // Ajustar al cargar la página
        adjustWrapper();
    }
});

console.log('Sistema Agrícola CoreUI Laravel - Cargado ✅');
