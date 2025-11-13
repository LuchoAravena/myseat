# app/controllers/qr_controller.rb
class QrController < ApplicationController
  def show
    require "rqrcode"
    svg = RQRCode::QRCode.new(root_url).as_svg(module_size: 6, standalone: true)
    render inline: svg, content_type: "image/svg+xml"
  end
end
