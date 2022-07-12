$(document).ready(function () {
    window.addEventListener("message", function (event) {
        if (event.data.hud == true) {
            $(".main-content").show();
        }

        if (event.data.hud == false) {
            $(".main-content").hide();
        }

        if (event.data.movie == true) {
            $("#movieTop").css("display", "block");
            $("#movieBottom").css("display", "block");
        }

        if (event.data.movie == false) {
            $("#movieTop").css("display", "none");
            $("#movieBottom").css("display", "none");
        }

        if (event.data.interact == true) {
            $('#allScreen').fadeIn(200);
            $('.titleContainer b').text("Projeto Z RP - discord.gg/KvMkKhfV3C");
        }

        if (event.data.interact == false) {
            $('#allScreen').fadeOut(200);
        }

        document.onkeyup = function (data) {
            if (data.which == 27) {
                $('#allScreen').fadeOut(200);
                $('body').removeClass("active");
                $.post('http://pz_hud/hideFocus', JSON.stringify({}));
            }
        }


        if (event.data.talking == true) {
            $("#speakDisplay").addClass("active");
        } else {
            $("#speakDisplay").removeClass("active");
        }

        if (event.data.sleep >= 80) {
            $(".sleep-indicator").show();
        } else {
            $(".sleep-indicator").hide();
        }

        if (event.data.mileage) {
            $("#milesDisplay").text(event.data.mileage + ' KM RODADOS');
        }

        if (event.data.health <= 1) {
            $("#healthDisplay").css("width", "0");
        } else {
            $("#healthDisplay").css("width", event.data.health + "%");
        }

        if (event.data.health <= 40 && event.data.health > 31) {
            $("#healthDisplay").css("background-color", '#ff9100');
            $(".life-border").css("background-color", '#a56e26c7');
        } else if (event.data.health <= 30 && event.data.health > 0) {
            $("#healthDisplay").css("background-color", '#ad2f2f');
            $(".life-border").css("background-color", '#943333c7');
        } else {
            $("#healthDisplay").css("background-color", '#2c8f3a');
            $(".life-border").css("background-color", '#175422c7');
        }

        if (event.data.ammoTotal >= 1) {
            $('#ammoContainer').html('')
            $(".ammo-row").css("opacity", "100%");
            let ammo = event.data.ammoTotal - event.data.ammoCurrent;
            let current = event.data.ammoCurrent < 10 ? '0' + event.data.ammoCurrent : event.data.ammoCurrent;

            let ammoPercent = (event.data.ammoCurrent / event.data.ammoTotalInClip * 100)

            $("#ammoDisplay").css("width", ammoPercent + "%");

            for (i = 0; i < event.data.ammoCurrent; i++) {
                $(`
                <div class="bullet">
                    <img src="./images/bullet.svg" alt="Bullet">
                </div>
               `).appendTo('#ammoContainer')
            }

            $("#ammoCount").html(current + '/' + ammo);
        } else {
            $(".ammo-row").css("opacity", "0%");
        }

        if (event.data.armour == 0) {
            $("#armourDisplay").html("0%");
        } else {
            $("#armourDisplay").html(event.data.armour + "%");
        }

        $("#waterDisplay").css("width", 100 - event.data.thirst + "%");
        $("#foodDisplay").css("width", 100 - event.data.hunger + "%");

        if (event.data.car == true) {

            $(".velocimeter-container").css('bottom', '20px');

            $("#fuelDisplay").css("width", event.data.fuel + "%");
            $("#carDisplay").css('width', Math.ceil((100 * (event.data.enginehealth / 1000))) + '%');

            $("#velocityDisplay").text(event.data.speed);
            if (event.data.enginehealth > 600) {
                $("#carDisplay").css('background-color', '#2c8f3a');
                $(".car-border").css('background-color', '#175422');
            } else if (event.data.enginehealth >= 350) {
                $("#carDisplay").css('background-color', '#db8c5f');
                $(".car-border").css('background-color', '#c96b34');
            } else if (event.data.enginehealth <= 350) {
                $("#carDisplay").css('background-color', '#db5f5f');
                $(".car-border").css('background-color', '#bb3333');
            }

        } else {
            $(".velocimeter-container").css('bottom', '-375px');
        }
        if (event.data.seatbelt == true) {
            $('#seatBeltIcon').attr("src", "images/seatbelt-green.svg");
        } else {
            $('#seatBeltIcon').attr("src", "images/seatbelt.svg");
        }
        if (event.data.farol == 0) {
            $('#carLight').attr("src", "images/car-light-dimmed.svg");
            $('#carLightHigh').attr("src", "images/car-light.svg");
        } else if (event.data.farol == 1) {
            $('#carLight').attr("src", "images/car-light-dimmed-green.svg");
            $('#carLightHigh').attr("src", "images/car-light.svg");
        } else if (event.data.farol == 2) {
            $('#carLight').attr("src", "images/car-light-dimmed.svg");
            $('#carLightHigh').attr("src", "images/car-light-green.svg");
        }
    })


});