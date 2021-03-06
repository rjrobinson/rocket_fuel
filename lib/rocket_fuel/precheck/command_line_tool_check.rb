require 'rocket_fuel/precheck/check'

module RocketFuel
  module Precheck
    class CommandLineToolCheck < Check
      check_name :command_line_tools
      register!

      TEN_NINE_RECEIPT_PATH = '/var/db/receipts/com.apple.pkg.CLTools_Executables.bom'
      DEFAULT_RECEIPT_PATH = '/var/db/receipts/com.apple.pkg.DeveloperToolsCLI.bom'

      def ok?
        installed?
      end

      def check?
        RocketFuel::SystemDetails.platform_family?(:mac)
      end

      protected

      def failure_message
        'Command Line Tools NOT found.'
      end

      def success_message
        'Command Line Tools found.'
      end

      def installed?
        FileTest.exist?(receipt_file)
      end

      def receipt_file
        if RocketFuel::SystemDetails.os.minor_version =~ /\A10.(9|(10))/
          TEN_NINE_RECEIPT_PATH
        else
          DEFAULT_RECEIPT_PATH
        end
      end
    end
  end
end
