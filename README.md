# Term Deposit Calculator

A Ruby-based command-line tool for calculating term deposit with different payment frequencies.
## Requirements

- Ruby 3.0.0 or higher
- Bundler gem

## Installation

1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd deposit_calculator
   ```

2. Install dependencies:
   ```bash
   bundle install
   ```

## Usage

The calculator is run through the command line using the main script:

```bash
ruby term_deposit_calc.rb calculate [OPTIONS]
```

### Command Options

| Option | Short | Type | Description |
|--------|-------|------|-------------|
| `--principal` | `-p` | Float | Start deposit amount (e.g., 10000) |
| `--rate` | `-r` | Float | Annual interest rate as percentage (e.g., 1.10) |
| `--term` | `-t` | Float | Investment term in years (e.g., 3) |
| `--frequency` | `-f` | String | Payment frequency: `monthly`, `quarterly`, `annually`, `at_maturity` |

### Examples

**Simple interest (payment at maturity):**
```bash
ruby term_deposit_calc.rb calculate --principal 10000 --rate 1.10 --term 3 --frequency at_maturity
```

**Compound interest (quarterly payments):**
```bash
ruby term_deposit_calc.rb calculate --principal 5000 --rate 2.5 --term 2 --frequency quarterly
```

### Sample Output

```
The Final balance is: $10330.00.
```

## Running Tests

```bash
# Run all tests
bundle exec rspec
```
