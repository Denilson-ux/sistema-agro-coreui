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

    // FIX: Manejar el toggle del sidebar para ajustar el wrapper y header
    const sidebar = document.querySelector('.sidebar');
    const wrapper = document.querySelector('.wrapper');
    const header = document.querySelector('.header');
    
    if (sidebar) {
        // Observar cambios en las clases del sidebar
        const observer = new MutationObserver(function(mutations) {
            mutations.forEach(function(mutation) {
                if (mutation.attributeName === 'class') {
                    updateLayout();
                }
            });
        });
        
        observer.observe(sidebar, {
            attributes: true,
            attributeFilter: ['class']
        });
        
        // Función para actualizar el layout
        function updateLayout() {
            const isNarrow = sidebar.classList.contains('sidebar-narrow');
            
            if (wrapper) {
                if (isNarrow) {
                    wrapper.style.paddingLeft = '56px';
                } else {
                    wrapper.style.paddingLeft = '256px';
                }
            }
            
            if (header) {
                if (isNarrow) {
                    header.style.left = '56px';
                } else {
                    header.style.left = '256px';
                }
            }
        }
        
        // Aplicar el layout inicial
        updateLayout();
        
        // También escuchar clicks en el botón toggle
        const toggleBtn = document.querySelector('[data-coreui-toggle="minimize"]');
        if (toggleBtn) {
            toggleBtn.addEventListener('click', function() {
                setTimeout(updateLayout, 50);
            });
        }
    }
});

console.log('Sistema Agrícola CoreUI Laravel - Cargado ✅');
