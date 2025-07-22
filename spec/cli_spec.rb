# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CLI::Commands::Calculate do
  let(:command) { described_class.new }

  describe 'validation' do
    it 'validates principal amount' do
      expect { command.call(principal: -1000.0, rate: 1.0, term: 1.0, frequency: 'monthly') }
        .to output(eq("Error: principal must be a positive number\nRun 'term_deposit_calc.rb calculate --help' for usage information.\n")).to_stdout
        .and raise_error(SystemExit)

      expect { command.call(principal: 0.0, rate: 1.0, term: 1.0, frequency: 'monthly') }
        .to output(eq("Error: principal must be a positive number\nRun 'term_deposit_calc.rb calculate --help' for usage information.\n")).to_stdout
        .and raise_error(SystemExit)
    end

    it 'validates interest rate' do
      expect { command.call(principal: 10000.0, rate: -1.0, term: 3.0, frequency: 'annually') }
        .to output(eq("Error: rate must be a non-negative number\nRun 'term_deposit_calc.rb calculate --help' for usage information.\n")).to_stdout
        .and raise_error(SystemExit)
    end

    it 'validates term' do
      expect { command.call(principal: 10000.0, rate: 1.10, term: 0.0, frequency: 'annually') }
        .to output(eq("Error: term must be a positive number\nRun 'term_deposit_calc.rb calculate --help' for usage information.\n")).to_stdout
        .and raise_error(SystemExit)

      expect { command.call(principal: 10000.0, rate: 1.10, term: -1.0, frequency: 'annually') }
        .to output(eq("Error: term must be a positive number\nRun 'term_deposit_calc.rb calculate --help' for usage information.\n")).to_stdout
        .and raise_error(SystemExit)
    end

    it 'validates payment frequency' do
      expect { command.call(principal: 10000.0, rate: 1.10, term: 3.0, frequency: 'invalid') }
        .to output(eq("Error: frequency must be one of: monthly, quarterly, annually, at_maturity\nRun 'term_deposit_calc.rb calculate --help' for usage information.\n")).to_stdout
        .and raise_error(SystemExit)
    end
  end
end
