module OpenAssets
  module Protocol

    # Represents a transaction output and its asset ID and asset quantity.
    class TransactionOutput
      attr_accessor :value
      attr_accessor :script
      attr_accessor :asset_id
      attr_accessor :asset_quantity
      attr_accessor :output_type

      attr_accessor :account
      attr_accessor :divisibility

      # @param [Integer] value The satoshi value of the output.
      # @param [Bitcoin::Script] script The script controlling redemption of the output.
      # @param [String] asset_id The asset ID of the output.
      # @param [Integer] asset_quantity The asset quantity of the output.
      # @param [OpenAssets::Transaction::OutPutType] output_type The type of the output.
      def initialize(value, script, asset_id = nil, asset_quantity = 0, output_type = OutputType::UNCOLORED, divisibility = 0)
        raise ArgumentError, "invalid output_type : #{output_type}" unless OutputType.all.include?(output_type)
        raise ArgumentError, "invalid asset_quantity asset_quantity should be unsignd integer. " unless asset_quantity.between?(0, MarkerOutput::MAX_ASSET_QUANTITY)
        @value = value
        @script = script
        @asset_id = asset_id
        @asset_quantity = asset_quantity
        @output_type = output_type
        @divisibility = divisibility
      end

      # calculate asset amount.
      # asset amount is the value obtained by converting the asset quantity to the unit of divisibility that are defined in the Asset definition file.
      def asset_amount
        @divisibility > 0 ? (@asset_quantity.to_f / (10 ** @divisibility)).to_f : @asset_quantity
      end

    end

  end
end