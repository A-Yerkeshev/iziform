// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

// import Rails from "@rails/ujs"
// import Turbolinks from "turbolinks"
// import * as ActiveStorage from "@rails/activestorage"
// import "channels"

// //= require jquery3
// //= require popper
// //= require bootstrap-sprockets
// //= require owl.carousel.min
// //= require owl_carousel_setup

// Rails.start()
// Turbolinks.start()
// ActiveStorage.start()



require("@rails/ujs").start()
//require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")
require("bootstrap")
require("@nathanvda/cocoon")

import $ from 'jquery';
window.jQuery = $;
window.$ = $;

require("packs/src/owl.carousel.min.js")
require("packs/src/main.js")