#
# Cookbook: redhat
# License: Apache 2.0
#
# Copyright 2014-2015, Bloomberg Finance L.P.
#
require 'poise'

module RedhatCookbook
  module Resource
    # @since 1.0.0
    class RedhatSubscription < Chef::Resource
      include Poise
      provides(:redhat_subscription, 'redhat')

      attribute(:machine_name, kind_of: String, name_attribute: true)
      attribute(:username, kind_of: String, required: true)
      attribute(:password, kind_of: String, required: true)

      attribute(:auto_attach, equal_to: [true, false], default: true)
      attribute(:activation_key, kind_of: String)
      attribute(:base_url, kind_of: String)
      attribute(:environment, kind_of: String)
      attribute(:force, equal_to: [true, false], default: false)
      attribute(:org, kind_of: String)
      attribute(:server_url, kind_of: String)
      attribute(:type, equal_to: %w{system hypervisor person domain rhui}, default: 'system')

      attribute(:sensitive, equal_to: [true, false], default: lazy { password.nil? })
    end
  end

  module Provider
    # @since 1.0.0
    class RedhatSubscription < Chef::Provider
      include Poise
      provides(:redhat_subscription, 'redhat')

      def action_create
        command = ['subscription-manager register']
        command << ['--name', new_resource.machine_name]
        command << ['--environment', new_resource.environment] if new_resource.environment
        command << ['--baseurl', new_resource.baseurl] if new_resource.baseurl
        command << ['--serverurl', new_resource.serverurl] if new_resource.serverurl
        command << ['--username', new_resource.username] if new_resource.username
        command << ['--password', new_resource.password] if new_resource.password
        command << ['--org', new_resource.org] if new_resource.org
        command << ['--activationkey', new_resource.activation_key] if new_resource.activation_key
        command << ['--type', new_resource.type] if new_resource.type
        command << '--auto-attach' if new_resource.auto_attach
        command << '--force' if new_resource.force
        notifying_block do
          execute command.flatten.join(' ') do
            sensitive new_resource.sensitive
            not_if 'subscription-manager identity'
            guard_interpreter :default
          end
        end
      end

      def action_delete
        notifying_block do
          execute 'subscription-manager unregister' do
            only_if 'subscription-manager identity'
            guard_interpreter :default
          end
        end
      end
    end
  end
end
