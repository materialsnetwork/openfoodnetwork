require 'open_food_network/reports/row'
require 'open_food_network/reports/rule'

module OpenFoodNetwork::Reports
  class Report
    class_attribute :_header, :_columns, :_rules_head

    # -- API
    def header
      _header
    end

    def columns
      _columns.to_a
    end

    def rules
      # Flatten linked list and return as hashes
      rules = []

      rule = _rules_head
      while rule
        rules << rule
        rule = rule.next
      end

      rules.map(&:to_h)
    end

    # -- DSL
    def self.header(*columns)
      self._header = columns
    end
  end
end
