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
        
        document.getElementById("visitors").innerHTML = "Your vistor number: " + count;
        console.log(data);
        return data;
    } catch (err) {
        console.error(err);
    }
}
getSubDomain();