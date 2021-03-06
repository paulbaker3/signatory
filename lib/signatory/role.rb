module Signatory
  class Role < API::Base
    def email
      attributes['email'] || 'noemail@rightsignature.com'
    end

    def to_xml(options = {})
      identifier = {}
      identifier.merge!({:role_id => role_id}) unless attributes['role_id'].nil?
      identifier.merge!({:role_name => role_name}) unless attributes['role_name'].nil?
      require 'builder' unless defined? ::Builder
      options[:indent] ||= 2
      xml = options[:builder] ||= ::Builder::XmlMarkup.new(:indent => options[:indent])
      xml.role(identifier) do
        if attributes['name'].nil?
          xml.tag!('must-sign', must_sign)
          xml.tag!('document-role-id', document_role_id)
          xml.role role
          xml.tag!('is-sender', is_sender)
        else
          xml.name name
          xml.email email
        end
      end
    end
  end
end