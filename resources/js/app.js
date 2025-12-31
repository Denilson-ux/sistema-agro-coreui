/**
 * Sistema Agrícola - CoreUI Laravel
 * JavaScript principal - SIMPLIFICADO
 */

import './bootstrap';
import 'simplebar';
import 'simplebar/dist/simplebar.css';
import * as coreui from '@coreui/coreui';

window.coreui = coreui;

// Inicializar CoreUI
document.addEventListener('DOMContentLoaded', function () {
    // Tooltips
    const tooltips = document.querySelectorAll('[data-coreui-toggle="tooltip"]');
    tooltips.forEach(el => new coreui.Tooltip(el));
    
    // Popovers
    const popovers = document.querySelectorAll('[data-coreui-toggle="popover"]');
    popovers.forEach(el => new coreui.Popover(el));
});

console.log('Sistema Agrícola ✅');
