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

    // FIX DEFINITIVO: Detectar TODOS los estados del sidebar
    const sidebar = document.querySelector('.sidebar');
    const wrapper = document.querySelector('.wrapper');
    
    if (sidebar && wrapper) {
        // Función para ajustar el wrapper
        function adjustWrapper() {
            const isHidden = sidebar.classList.contains('hide');
            // CoreUI puede usar 'sidebar-unfoldable' O 'sidebar-narrow-unfoldable'
            const isUnfoldable = sidebar.classList.contains('sidebar-unfoldable') || 
                               sidebar.classList.contains('sidebar-narrow-unfoldable');
            const isHovering = sidebar.matches(':hover');
            
            console.log('Sidebar oculto (hide):', isHidden);
            console.log('Sidebar plegado (unfoldable/narrow):', isUnfoldable);
            console.log('Sidebar hover:', isHovering);
            console.log('Clases actuales:', sidebar.className);
            
            if (isHidden) {
                // Sidebar completamente oculto - wrapper sin padding
                wrapper.style.paddingLeft = '0px';
                console.log('✅ Aplicando padding: 0px (oculto)');
            } else if (isUnfoldable && isHovering) {
                // Sidebar minimizado PERO con hover - wrapper con padding completo temporalmente
                wrapper.style.paddingLeft = '256px';
                console.log('✅ Aplicando padding: 256px (hover sobre minimizado)');
            } else if (isUnfoldable) {
                // Sidebar minimizado sin hover - wrapper con padding pequeño
                wrapper.style.paddingLeft = '64px';
                console.log('✅ Aplicando padding: 64px (minimizado)');
            } else {
                // Sidebar abierto completo - wrapper con padding normal
                wrapper.style.paddingLeft = '256px';
                console.log('✅ Aplicando padding: 256px (abierto)');
            }
        }
        
        // Observar cambios en las clases del sidebar
        const observer = new MutationObserver(function(mutations) {
            mutations.forEach(function(mutation) {
                if (mutation.attributeName === 'class') {
                    console.log('🔄 Clases del sidebar cambiaron:', sidebar.className);
                    adjustWrapper();
                }
            });
        });
        
        observer.observe(sidebar, {
            attributes: true,
            attributeFilter: ['class']
        });
        
        // Escuchar eventos de mouse en el sidebar para detectar hover
        sidebar.addEventListener('mouseenter', function() {
            console.log('🖱️ Mouse entró al sidebar');
            adjustWrapper();
        });
        
        sidebar.addEventListener('mouseleave', function() {
            console.log('🖱️ Mouse salió del sidebar');
            adjustWrapper();
        });
        
        // Ajustar al cargar la página
        console.log('🚀 Inicializando sidebar...');
        console.log('Clases iniciales:', sidebar.className);
        adjustWrapper();
        
        // Escuchar el botón toggle del header (botón hamburguesa arriba)
        const headerToggleBtn = document.querySelector('.header-toggler');
        if (headerToggleBtn) {
            headerToggleBtn.addEventListener('click', function() {
                console.log('🔘 Botón header clickeado');
                setTimeout(adjustWrapper, 50);
            });
            console.log('✅ Listener agregado al botón header');
        }
        
        // Escuchar el botón toggle del sidebar (botón de abajo en el sidebar)
        const sidebarToggleBtn = document.querySelector('.sidebar-toggler');
        if (sidebarToggleBtn) {
            sidebarToggleBtn.addEventListener('click', function() {
                console.log('🔘 Botón sidebar-toggler clickeado');
                setTimeout(adjustWrapper, 50);
            });
            console.log('✅ Listener agregado al botón sidebar-toggler');
        }
    } else {
        console.error('❌ Sidebar o wrapper no encontrados');
        console.log('Sidebar:', sidebar);
        console.log('Wrapper:', wrapper);
    }
});

console.log('✅ Sistema Agrícola CoreUI Laravel - Cargado');
