# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `logcraft` gem.
# Please instead update this file by running `bin/tapioca gem logcraft`.


# source://logcraft//lib/logcraft/version.rb#3
module Logcraft
  extend ::Logcraft::LogContextHelper

  class << self
    # source://logcraft//lib/logcraft.rb#20
    def logger(name, level = T.unsafe(nil)); end
  end
end

# source://logcraft//lib/logcraft/log_context_helper.rb#4
module Logcraft::LogContextHelper
  # source://logcraft//lib/logcraft/log_context_helper.rb#12
  def add_to_log_context(context); end

  # source://logcraft//lib/logcraft/log_context_helper.rb#5
  def within_log_context(context = T.unsafe(nil)); end
end

# source://logcraft//lib/logcraft/log_layout.rb#6
class Logcraft::LogLayout < ::Logging::Layout
  # @return [LogLayout] a new instance of LogLayout
  #
  # source://logcraft//lib/logcraft/log_layout.rb#10
  def initialize(global_context = T.unsafe(nil), options = T.unsafe(nil)); end

  # source://logcraft//lib/logcraft/log_layout.rb#16
  def format(event); end

  private

  # source://logcraft//lib/logcraft/log_layout.rb#25
  def background_of(event); end

  # source://logcraft//lib/logcraft/log_layout.rb#43
  def dynamic_log_context; end

  # source://logcraft//lib/logcraft/log_layout.rb#35
  def evaluated_global_context; end

  # source://logcraft//lib/logcraft/log_layout.rb#69
  def format_cause(cause); end

  # source://logcraft//lib/logcraft/log_layout.rb#62
  def format_exception(exception); end

  # source://logcraft//lib/logcraft/log_layout.rb#58
  def format_hash(hash); end

  # source://logcraft//lib/logcraft/log_layout.rb#47
  def message_from(payload); end
end

# source://logcraft//lib/logcraft/log_layout.rb#7
Logcraft::LogLayout::JSON_FORMATTER = T.let(T.unsafe(nil), Proc)

# source://logcraft//lib/logcraft/log_layout.rb#8
Logcraft::LogLayout::LOGGING_LEVEL_FORMATTER = T.let(T.unsafe(nil), Proc)

# source://logcraft//lib/logcraft/rails.rb#7
module Logcraft::Rails; end

# source://logcraft//lib/logcraft/rails/active_record.rb#5
module Logcraft::Rails::ActiveRecord; end

# source://logcraft//lib/logcraft/rails/active_record/log_subscriber.rb#6
class Logcraft::Rails::ActiveRecord::LogSubscriber < ::ActiveSupport::LogSubscriber
  # source://logcraft//lib/logcraft/rails/active_record/log_subscriber.rb#7
  def sql(event); end

  private

  # source://logcraft//lib/logcraft/rails/active_record/log_subscriber.rb#20
  def basic_message_from(event); end

  # source://logcraft//lib/logcraft/rails/active_record/log_subscriber.rb#13
  def log_message_from(event); end

  # source://logcraft//lib/logcraft/rails/active_record/log_subscriber.rb#29
  def params_from(event); end

  # source://logcraft//lib/logcraft/rails/active_record/log_subscriber.rb#43
  def type_casted_values_from(event); end

  # source://logcraft//lib/logcraft/rails/active_record/log_subscriber.rb#48
  def value_of(param, value); end
end

# source://logcraft//lib/logcraft/rails/log_subscription_handler.rb#7
class Logcraft::Rails::LogSubscriptionHandler
  class << self
    # source://logcraft//lib/logcraft/rails/log_subscription_handler.rb#26
    def attach(subscriber_class, namespace); end

    # source://logcraft//lib/logcraft/rails/log_subscription_handler.rb#9
    def detach(subscriber_class, namespace); end
  end
end

# source://logcraft//lib/logcraft/rails/request_id_logger.rb#5
class Logcraft::Rails::RequestIdLogger
  include ::Logcraft::LogContextHelper

  # @return [RequestIdLogger] a new instance of RequestIdLogger
  #
  # source://logcraft//lib/logcraft/rails/request_id_logger.rb#8
  def initialize(app); end

  # source://logcraft//lib/logcraft/rails/request_id_logger.rb#12
  def call(env); end
end

# source://logcraft//lib/logcraft/rails/request_logger.rb#5
class Logcraft::Rails::RequestLogger
  # @return [RequestLogger] a new instance of RequestLogger
  #
  # source://logcraft//lib/logcraft/rails/request_logger.rb#6
  def initialize(app, logger, config); end

  # source://logcraft//lib/logcraft/rails/request_logger.rb#12
  def call(env); end

  private

  # source://logcraft//lib/logcraft/rails/request_logger.rb#32
  def current_time_in_milliseconds; end

  # source://logcraft//lib/logcraft/rails/request_logger.rb#41
  def instrumentation_finish(request); end

  # source://logcraft//lib/logcraft/rails/request_logger.rb#36
  def instrumentation_start(request); end

  # source://logcraft//lib/logcraft/rails/request_logger.rb#46
  def log_request(request, status, start_time); end

  # source://logcraft//lib/logcraft/rails/request_logger.rb#71
  def params_to_log(request); end

  # @return [Boolean]
  #
  # source://logcraft//lib/logcraft/rails/request_logger.rb#60
  def path_ignored?(request); end

  # source://logcraft//lib/logcraft/rails/request_logger.rb#79
  def status_for_error(error); end
end

# source://logcraft//lib/logcraft/railtie.rb#6
class Logcraft::Railtie < ::Rails::Railtie; end

# source://logcraft//lib/logcraft/version.rb#4
Logcraft::VERSION = T.let(T.unsafe(nil), String)
