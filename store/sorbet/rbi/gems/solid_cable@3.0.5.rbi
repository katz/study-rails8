# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `solid_cable` gem.
# Please instead update this file by running `bin/tapioca gem solid_cable`.


# source://solid_cable//lib/action_cable/subscription_adapter/solid_cable.rb#7
module ActionCable
  private

  # source://actioncable/8.0.1/lib/action_cable.rb#77
  def server; end

  class << self
    # source://actioncable/8.0.1/lib/action_cable/deprecator.rb#6
    def deprecator; end

    # source://actioncable/8.0.1/lib/action_cable/gem_version.rb#7
    def gem_version; end

    # source://actioncable/8.0.1/lib/action_cable.rb#77
    def server; end

    # source://actioncable/8.0.1/lib/action_cable/version.rb#9
    def version; end
  end
end

# source://solid_cable//lib/action_cable/subscription_adapter/solid_cable.rb#8
module ActionCable::SubscriptionAdapter; end

# source://solid_cable//lib/action_cable/subscription_adapter/solid_cable.rb#9
class ActionCable::SubscriptionAdapter::SolidCable < ::ActionCable::SubscriptionAdapter::Base
  include ::ActionCable::SubscriptionAdapter::ChannelPrefix

  # @return [SolidCable] a new instance of SolidCable
  #
  # source://solid_cable//lib/action_cable/subscription_adapter/solid_cable.rb#12
  def initialize(*_arg0); end

  # source://actioncable/8.0.1/lib/action_cable/subscription_adapter/channel_prefix.rb#8
  def broadcast(channel, payload); end

  # source://solid_cable//lib/action_cable/subscription_adapter/solid_cable.rb#31
  def shutdown(*_arg0, **_arg1, &_arg2); end

  # source://actioncable/8.0.1/lib/action_cable/subscription_adapter/channel_prefix.rb#13
  def subscribe(channel, callback, success_callback = T.unsafe(nil)); end

  # source://actioncable/8.0.1/lib/action_cable/subscription_adapter/channel_prefix.rb#18
  def unsubscribe(channel, callback); end

  private

  # source://solid_cable//lib/action_cable/subscription_adapter/solid_cable.rb#34
  def listener; end
end

# source://solid_cable//lib/action_cable/subscription_adapter/solid_cable.rb#40
class ActionCable::SubscriptionAdapter::SolidCable::Listener < ::ActionCable::SubscriptionAdapter::SubscriberMap
  # @return [Listener] a new instance of Listener
  #
  # source://solid_cable//lib/action_cable/subscription_adapter/solid_cable.rb#41
  def initialize(event_loop); end

  # source://solid_cable//lib/action_cable/subscription_adapter/solid_cable.rb#71
  def add_channel(channel, on_success); end

  # source://solid_cable//lib/action_cable/subscription_adapter/solid_cable.rb#80
  def invoke_callback(*_arg0); end

  # source://solid_cable//lib/action_cable/subscription_adapter/solid_cable.rb#52
  def listen; end

  # source://solid_cable//lib/action_cable/subscription_adapter/solid_cable.rb#76
  def remove_channel(channel); end

  # source://solid_cable//lib/action_cable/subscription_adapter/solid_cable.rb#62
  def shutdown; end

  private

  # source://solid_cable//lib/action_cable/subscription_adapter/solid_cable.rb#104
  def broadcast_messages; end

  # source://solid_cable//lib/action_cable/subscription_adapter/solid_cable.rb#100
  def channels; end

  # source://solid_cable//lib/action_cable/subscription_adapter/solid_cable.rb#148
  def create_self_pipe; end

  # Returns the value of attribute event_loop.
  #
  # source://solid_cable//lib/action_cable/subscription_adapter/solid_cable.rb#85
  def event_loop; end

  # source://solid_cable//lib/action_cable/subscription_adapter/solid_cable.rb#128
  def interrupt; end

  # source://solid_cable//lib/action_cable/subscription_adapter/solid_cable.rb#136
  def interruptible_sleep(time); end

  # source://solid_cable//lib/action_cable/subscription_adapter/solid_cable.rb#96
  def last_id; end

  # Sets the attribute last_id
  #
  # @param value the value to set the attribute last_id to.
  #
  # source://solid_cable//lib/action_cable/subscription_adapter/solid_cable.rb#86
  def last_id=(_arg0); end

  # Sets the attribute running
  #
  # @param value the value to set the attribute running to.
  #
  # source://solid_cable//lib/action_cable/subscription_adapter/solid_cable.rb#86
  def running=(_arg0); end

  # @return [Boolean]
  #
  # source://solid_cable//lib/action_cable/subscription_adapter/solid_cable.rb#88
  def running?; end

  # Self-pipe for signal-handling (http://cr.yp.to/docs/selfpipe.html)
  #
  # source://solid_cable//lib/action_cable/subscription_adapter/solid_cable.rb#144
  def self_pipe; end

  # Returns the value of attribute thread.
  #
  # source://solid_cable//lib/action_cable/subscription_adapter/solid_cable.rb#85
  def thread; end

  # source://solid_cable//lib/action_cable/subscription_adapter/solid_cable.rb#122
  def wake_up; end

  # source://solid_cable//lib/action_cable/subscription_adapter/solid_cable.rb#114
  def with_polling_volume; end
end

# source://solid_cable//lib/action_cable/subscription_adapter/solid_cable.rb#126
ActionCable::SubscriptionAdapter::SolidCable::Listener::SELF_PIPE_BLOCK_SIZE = T.let(T.unsafe(nil), Integer)

# source://solid_cable//lib/solid_cable/version.rb#3
module SolidCable
  class << self
    # @return [Boolean]
    #
    # source://solid_cable//lib/solid_cable.rb#25
    def autotrim?; end

    # source://solid_cable//lib/solid_cable.rb#9
    def connects_to; end

    # source://solid_cable//lib/solid_cable.rb#21
    def message_retention; end

    # source://solid_cable//lib/solid_cable.rb#17
    def polling_interval; end

    # source://railties/8.0.1/lib/rails/engine.rb#413
    def railtie_helpers_paths; end

    # source://railties/8.0.1/lib/rails/engine.rb#396
    def railtie_namespace; end

    # source://railties/8.0.1/lib/rails/engine.rb#417
    def railtie_routes_url_helpers(include_path_helpers = T.unsafe(nil)); end

    # @return [Boolean]
    #
    # source://solid_cable//lib/solid_cable.rb#13
    def silence_polling?; end

    # source://railties/8.0.1/lib/rails/engine.rb#402
    def table_name_prefix; end

    # source://solid_cable//lib/solid_cable.rb#29
    def trim_batch_size; end

    # For every write that we do, we attempt to delete trim_chance times as
    # many records. This ensures there is downward pressure on the cache size
    # while there is valid data to delete. Read this as 'every time the trim job
    # runs theres a trim_multiplier chance this trims'. Adjust number to make it
    # more or less likely to trim. Only works like this if trim_batch_size is
    # 100
    #
    # source://solid_cable//lib/solid_cable.rb#47
    def trim_chance; end

    # source://railties/8.0.1/lib/rails/engine.rb#409
    def use_relative_model_naming?; end

    # source://solid_cable//lib/solid_cable.rb#37
    def use_skip_locked; end

    private

    # source://solid_cable//lib/solid_cable.rb#52
    def cable_config; end

    # source://solid_cable//lib/solid_cable.rb#56
    def parse_duration(duration, default:); end
  end
end

# source://solid_cable//lib/solid_cable/engine.rb#4
class SolidCable::Engine < ::Rails::Engine
  class << self
    private

    # source://activesupport/8.0.1/lib/active_support/class_attribute.rb#15
    def __class_attr___callbacks; end

    # source://activesupport/8.0.1/lib/active_support/class_attribute.rb#17
    def __class_attr___callbacks=(new_value); end
  end
end

class SolidCable::Message < ::SolidCable::Record
  include ::SolidCable::Message::GeneratedAttributeMethods
  include ::SolidCable::Message::GeneratedAssociationMethods

  class << self
    def broadcast(channel, payload); end

    # source://activerecord/8.0.1/lib/active_record/scoping/named.rb#174
    def broadcastable(*args, **_arg1); end

    def channel_hash_for(channel); end
    def channel_hashes_for(channels); end

    # source://activerecord/8.0.1/lib/active_record/scoping/named.rb#174
    def trimmable(*args, **_arg1); end

    private

    # source://activesupport/8.0.1/lib/active_support/class_attribute.rb#15
    def __class_attr__validators; end

    # source://activesupport/8.0.1/lib/active_support/class_attribute.rb#17
    def __class_attr__validators=(new_value); end

    # source://activesupport/8.0.1/lib/active_support/class_attribute.rb#15
    def __class_attr_defined_enums; end

    # source://activesupport/8.0.1/lib/active_support/class_attribute.rb#17
    def __class_attr_defined_enums=(new_value); end
  end
end

module SolidCable::Message::GeneratedAssociationMethods; end
module SolidCable::Message::GeneratedAttributeMethods; end

class SolidCable::Record < ::ActiveRecord::Base
  include ::SolidCable::Record::GeneratedAttributeMethods
  include ::SolidCable::Record::GeneratedAssociationMethods

  class << self
    def non_blocking_lock; end

    private

    # source://activesupport/8.0.1/lib/active_support/class_attribute.rb#15
    def __class_attr__validators; end

    # source://activesupport/8.0.1/lib/active_support/class_attribute.rb#17
    def __class_attr__validators=(new_value); end

    # source://activesupport/8.0.1/lib/active_support/class_attribute.rb#15
    def __class_attr_defined_enums; end

    # source://activesupport/8.0.1/lib/active_support/class_attribute.rb#17
    def __class_attr_defined_enums=(new_value); end
  end
end

module SolidCable::Record::GeneratedAssociationMethods; end
module SolidCable::Record::GeneratedAttributeMethods; end

class SolidCable::TrimJob < ::ActiveJob::Base
  def perform; end

  private

  def trim?; end
  def trim_batch_size; end
end

# source://solid_cable//lib/solid_cable/version.rb#4
SolidCable::VERSION = T.let(T.unsafe(nil), String)
