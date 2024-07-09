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


async function getSubDomain(){
    
    try {
        const domain = document.querySelector(".vistorcount")
        const subdomain = window.location.hostname.split('.').slice(0, -2).join('.');
        const apigw_url = "https://bgow867901.execute-api.us-east-1.amazonaws.com/default/VisitorCounter"
        uri = apigw_url  + "?subdomain=" + subdomain;
        
        let response = await fetch(uri, {method: 'GET',
        });
        let data = await response.json();

        console.log(data);
        console.log(data);
        count = data['resume_count'];
        console.log('count: ' + count);
        
        document.getElementById("visitors").innerHTML = count;
        console.log(data);
        return data;
    } catch (err) {
        console.error(err);
    }
}
getSubDomain();

// async function get_visitors() {
//     // call post api request function
//     //await post_visitor();
//     try {
//         let response = await fetch('https://cv6b7x3ici.execute-api.eu-west-2.amazonaws.com/default/VisitorCounter', {
//             method: 'GET',
//         });
//         let data = await response.json()
//         document.getElementById("visitors").innerHTML = data['count'];
//         console.log(data);
//         return data;
//     } catch (err) {
//         console.error(err);
//     }
// }

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
