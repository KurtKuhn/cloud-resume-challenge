/*!
* Start Bootstrap - Resume v7.0.6 (https://startbootstrap.com/theme/resume)
* Copyright 2013-2023 Start Bootstrap
* Licensed under MIT (https://github.com/StartBootstrap/startbootstrap-resume/blob/master/LICENSE)
*/
//
// Scripts
// 

// Get subdomain which will passed into API-GW
// const subdomain = window.location.hostname.split('.').slice(0, -1).join('.');
// console.log(subdomain); // "my.company"


function getSubDomain(){
    const domain = document.querySelector(".vistorcount")
    const subdomain = window.location.hostname.split('.').slice(0, -2).join('.');
    // subdomain = "test"
    console.log(window.location.hostname); // "my.company"
    domain.innerHTML = `Hello, I am the subdomain: ${subdomain}`
    return subdomain
}
getSubDomain();

window.addEventListener('DOMContentLoaded', event => {

    // Activate Bootstrap scrollspy on the main nav element
    const sideNav = document.body.querySelector('#sideNav');
    if (sideNav) {
        new bootstrap.ScrollSpy(document.body, {
            target: '#sideNav',
            rootMargin: '0px 0px -40%',
        });
    };

    // Collapse responsive navbar when toggler is visible
    const navbarToggler = document.body.querySelector('.navbar-toggler');
    const responsiveNavItems = [].slice.call(
        document.querySelectorAll('#navbarResponsive .nav-link')
    );
    responsiveNavItems.map(function (responsiveNavItem) {
        responsiveNavItem.addEventListener('click', () => {
            if (window.getComputedStyle(navbarToggler).display !== 'none') {
                navbarToggler.click();
            }
        });
    });

});
