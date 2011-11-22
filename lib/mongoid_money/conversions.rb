module Mongoid
  module Extensions
    module Money
      module Conversions
        def set(value)
          return nil if value.blank?
          begin
            value.hundredths
          rescue
            value
          end
        end
        def get(value)
          return nil if value.blank?
          begin
            self.new_from_hundredths value
          rescue
            nil
          end
        end
      end
    end
  end
end