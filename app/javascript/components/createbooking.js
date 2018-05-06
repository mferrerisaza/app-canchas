const http = new XMLHttpRequest();
const url = ('/bookings');
const params = "field_id=1&date=27/05/2018&splitable=true";

http.open("POST", url, true);

http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

http.onreadystatechange = function() {//Call a function when the state changes.
    if(http.readyState == 4 && http.status == 200) {
        alert("HW");
    }
}
http.send(params);
