require 'wechat/api_base'
require 'wechat/http_client'
require 'wechat/token/public_access_token'
require 'wechat/ticket/public_jsapi_ticket'
require 'wechat/concern/common'

module Wechat
  class Api < ApiBase
    include Concern::Common
    DEVICE_BASE = 'https://api.weixin.qq.com/device/'.freeze

    def device_bind(open_id, device_id)
      post 'compel_bind', {device_id: device_id, openid: open_id}.to_json, base: DEVICE_BASE
    end

    def device_unbind(open_id, device_id)
      post 'compel_unbind', {device_id: device_id, openid: open_id}.to_json, base: DEVICE_BASE
    end

    def device_transmsg(device_type, open_id, device_id, content)
      post 'transmsg', {device_type: device_type, open_id: open_id, device_id: device_id, content: content}.to_json, base: DEVICE_BASE
    end

    def device_authorize(device_num, device_list, op_type, product_id)
      post 'authorize_device', {device_num: device_num, device_list: device_list, op_type: op_type, product_id: product_id}.to_json, base: DEVICE_BASE
    end

    def template_message_send(message)
      post 'message/template/send', message.to_json, content_type: :json
    end

    def list_message_template
      get 'template/get_all_private_template'
    end

    def add_message_template(template_id_short)
      post 'template/api_add_template', JSON.generate(template_id_short: template_id_short)
    end

    def del_message_template(template_id)
      post 'template/del_private_template', JSON.generate(template_id: template_id)
    end
  end
end
