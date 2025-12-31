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

    // FIX DEFINITIVO: Detectar por ANCHO del sidebar en lugar de clase
    const sidebar = document.querySelector('.sidebar');
    const wrapper = document.querySelector('.wrapper');
    
    if (sidebar && wrapper) {
        // Función para ajustar el wrapper según el ancho del sidebar
        function adjustWrapper() {
            // Obtener el ancho actual del sidebar
            const sidebarWidth = sidebar.offsetWidth;
            
            console.log('Ancho del sidebar:', sidebarWidth + 'px');
            
            // Ajustar el padding del wrapper al ancho exacto del sidebar
            wrapper.style.paddingLeft = sidebarWidth + 'px';
            
            console.log('Aplicando padding:', sidebarWidth + 'px');
        }
        
        // Observar cambios en el estilo del sidebar (ancho)
        const observer = new MutationObserver(function(mutations) {
            mutations.forEach(function(mutation) {
                if (mutation.attributeName === 'class' || mutation.attributeName === 'style') {
                    console.log('Sidebar cambió, reajustando wrapper');
                    // Esperar un poco para que la transición termine
                    setTimeout(adjustWrapper, 50);
                }
            });
        });
        
        observer.observe(sidebar, {
            attributes: true,
            attributeFilter: ['class', 'style']
        });
        
        // Ajustar al cargar la página
        adjustWrapper();
        
        // También escuchar eventos de click en el botón toggle
        const toggleBtn = document.querySelector('[data-coreui-toggle="unfoldable"]');
        if (toggleBtn) {
            toggleBtn.addEventListener('click', function() {
                console.log('Botón toggle clickeado');
                setTimeout(adjustWrapper, 350); // Esperar la transición CSS
            });
        }
        
        // Escuchar cambios de tamaño de ventana
        window.addEventListener('resize', adjustWrapper);
        
        // Escuchar transiciones del sidebar
        sidebar.addEventListener('transitionend', function(e) {
            if (e.propertyName === 'width') {
                console.log('Transición de ancho finalizada');
                adjustWrapper();
            }
        });
    } else {
        console.error('Sidebar o wrapper no encontrados');
    }
});

console.log('Sistema Agrícola CoreUI Laravel - Cargado ✅');
