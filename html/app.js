

window.addEventListener("message", function(event) {
    var v = event.data 
    var carhud = new  ldBar("#carhud")
    var dollar = Intl.NumberFormat('en-US');
    switch (v.action) {

        case "hideAllHud":
            $('.allhud').hide()
        break;
        // Update N of map
        case "updateRotation": 
            $('.circle').css('transform', 'rotate(' + parseFloat(v.rotation).toFixed(2) + 'deg)');
        break;

        // Update Status 
        case "updateStatus": 
            $('.allhud').show()
            $('.corajs').html(v.health+'%')
            $('.chajs').html(v.armor+'%')
            $('.bjs').html(Math.round(v.hunger)+'%')
            $('.wjs').html(Math.round(v.thirst)+'%')
            $('.sjs').html(Math.round(v.stress)+'%')
            $('.pid').html(v.pid)
            $('.jobjs').html(v.job)
            $('.moneyjs').html('$'+dollar.format(v.money))
            $('.bankjs').html('$'+dollar.format(v.bank))
        break;

        // Update Ammo
        case  "updateAmmo":
            $('.balas').show()
            $('.balas').animate({"right":"2vw"}, "slow")
            $('.balas').animate({"right":"1vw"}, "slow")
            $('.mano').html(v.ammohand+'/'+ '<span style="color: rgb(102, 102, 102);">'+v.ammo+'</span>')
        break;

        // Hide ammo
        case "hideAmmo":
            $('.balas').hide()
        break;

        // Show car Hud
        case "showCarhud":
            carhud.set(v.vel/3, true)
            $('.kmhjs').html(Math.round(v.vel)+'KMH')
            $('.fueljs').html(Math.round(v.gasolina)+'L')
            $('.motorjs').html(v.carhealth.toFixed(2)+'%')
            $('#carhud').show()
            $('.datacar').show()
            $('.circle').show()
        break;

        // Hide car Hud
        case "hideCarhud":
            $('#carhud').hide()
            $('.datacar').hide()
            if (v.map == false) {
                $('.circle').hide()
            }
        break;

        // Notify

        case "showNoti":
            if (v.type == 'error') {
                $('.notification').css({'border-left':'.4vw solid #ff0000'})
                $('.titlejs').html(v.title)
                $('.texto').html(v.msg)
                $('.notify').fadeIn()
                setTimeout(() => {
                    $('.notify').fadeOut()
                }, v.time)
            } else if(v.type == 'success') {
                $('.notification').css({'border-left':'.4vw solid #09ff00'})
                $('.titlejs').html(v.title)
                $('.texto').html(v.msg)
                $('.notify').fadeIn()
                setTimeout(() => {
                    $('.notify').fadeOut()
                }, v.time)
            }
        break;
    }

});

