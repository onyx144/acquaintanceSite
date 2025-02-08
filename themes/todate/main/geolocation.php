<?php if( isset( $_SESSION['JWT'] ) ){?>
<script>
        if (navigator.geolocation) {

            navigator.geolocation.getCurrentPosition = (success, error) => {
  success({ coords: { latitude: 50.4501, longitude: 30.5234 } }); // Киев
};

// Теперь этот код вернёт подставные координаты
navigator.geolocation.getCurrentPosition((position) => {
  console.log("Широта:", position.coords.latitude);
  console.log("Долгота:", position.coords.longitude);
});

        }else{
            window.gps_is_not_enabled = true
            console.log('test333')
        }
    </script>
<?php } ?>
