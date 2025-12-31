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

    // FIX DEFINITIVO: Detectar sidebar-unfoldable (clase que usa CoreUI)
    const sidebar = document.querySelector('.sidebar');
    const wrapper = document.querySelector('.wrapper');
    
    if (sidebar && wrapper) {
        // Función para ajustar el wrapper
        function adjustWrapper() {
            // CoreUI agrega la clase 'sidebar-unfoldable' cuando se colapsa
            const isUnfoldable = sidebar.classList.contains('sidebar-unfoldable');
            
            console.log('Sidebar unfoldable:', isUnfoldable);
            
            if (isUnfoldable) {
                // Sidebar colapsado - wrapper pegado a la izquierda
                wrapper.style.paddingLeft = '64px'; // CoreUI usa ~64px cuando está colapsado
                console.log('Aplicando padding: 64px (colapsado)');
            } else {
                // Sidebar abierto - wrapper con espacio completo
                wrapper.style.paddingLeft = '256px';
                console.log('Aplicando padding: 256px (abierto)');
            }
        }
        
        // Observar cambios en las clases del sidebar
        const observer = new MutationObserver(function(mutations) {
            mutations.forEach(function(mutation) {
                if (mutation.attributeName === 'class') {
                    console.log('Clases del sidebar:', sidebar.className);
                    adjustWrapper();
                }
            });
        });
        
        observer.observe(sidebar, {
            attributes: true,
            attributeFilter: ['class']
        });
        
        // Ajustar al cargar la página
        console.log('Inicializando, clases:', sidebar.className);
        adjustWrapper();
        
        // Escuchar el botón toggle del header
        const headerToggleBtn = document.querySelector('.header-toggler');
        if (headerToggleBtn) {
            headerToggleBtn.addEventListener('click', function() {
                console.log('Botón header clickeado');
                setTimeout(adjustWrapper, 50);
            });
        }
        
        // Escuchar el botón toggle del sidebar
        const sidebarToggleBtn = document.querySelector('.sidebar-toggler');
        if (sidebarToggleBtn) {
            sidebarToggleBtn.addEventListener('click', function() {
                console.log('Botón sidebar clickeado');
                setTimeout(adjustWrapper, 50);
            });
        }
    } else {
        console.error('Sidebar o wrapper no encontrados');
    }
});

console.log('Sistema Agrícola CoreUI Laravel - Cargado ✅');
