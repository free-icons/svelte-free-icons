#!/bin/bash

# Directory containing SVG files (passed as first argument)
INPUT_DIR=$1
OUTPUT_DIR="${1}/svelte"
INDEX_FILE="$OUTPUT_DIR/index.ts"

# Ensure the output folder exists
mkdir -p "$OUTPUT_DIR"

# Ensure index.ts exists
touch "$INDEX_FILE"

# Function to map and replace leading numbers
fix_leading_number() {
    local filename="$1"

    # Explicit mappings based on the provided table
    declare -A num_map=( ["00"]="ZeroZero" ["0"]="Zero" ["1"]="One" ["2"]="Two"
                         ["3"]="Three" ["4"]="Four" ["5"]="Five" ["6"]="Six"
                         ["7"]="Seven" ["8"]="Eight" ["9"]="Nine" ["360"]="ThreeSixZero" 
                         ["42"]="FourTwo" ["500"]="FiveZeroZero")

    # Extract leading number pattern (if any)
    if [[ "$filename" =~ ^([0-9]+)(-)?(.*) ]]; then
        leading_number="${BASH_REMATCH[1]}"
        rest_of_name="${BASH_REMATCH[3]}"

        # Check if mapping exists, otherwise leave unchanged
        if [[ -n "${num_map[$leading_number]}" ]]; then
            filename="${num_map[$leading_number]}-$rest_of_name"
        fi
    fi

    echo "$filename"
}

# Function to convert filename to PascalCase, handling "sharp-" prefix separately
convert_to_pascal_case() {
    local filename="$1"

    # If the filename starts with "sharp-", remove the first two words
    if [[ "$filename" == sharp-* ]]; then
        filename=$(echo "$filename" | sed -E 's/^([^ -]+-[^ -]+-)//')  # Remove first two words
    else
        filename=$(echo "$filename" | sed -E 's/^[^-]+-//')  # Remove only the first word
    fi

    # Apply fixed number mapping AFTER removing prefixes
    filename=$(fix_leading_number "$filename")

    # Convert remaining name to PascalCase
    echo "$filename" | awk -F'-' '{
        for (i=1; i<=NF; i++) {
            $i = toupper(substr($i, 1, 1)) tolower(substr($i, 2))
        }
        print $0
    }' OFS=""
}

# Function to update index.ts
update_index_file() {
    local component_name="$1"
    local export_line="export { default as $component_name } from './$component_name.svelte';"

    # Check if the line already exists
    if ! grep -Fxq "$export_line" "$INDEX_FILE"; then
        echo "$export_line" >> "$INDEX_FILE"
        echo "🔹 Added to index.ts: $export_line"
    else
        echo "⚠️  $component_name is already in index.ts, skipping."
    fi
}

# Function to convert an SVG file to a Svelte component
convert_svg_to_svelte() {
    local svg_file="$1"
    local base_name
    base_name=$(basename "$svg_file" .svg) # Remove extension
    local component_name
    component_name=$(convert_to_pascal_case "$base_name") # Convert to PascalCase
    local svelte_file="$OUTPUT_DIR/$component_name.svelte"

    echo "🔄 Converting $svg_file to $svelte_file..."

    # Read SVG content
    svg_content=$(cat "$svg_file")

    # Modify the first <svg> tag to include required attributes
    svg_content=$(echo "$svg_content" | sed -E 's/<svg[^>]*>/<svg\n  xmlns="http:\/\/www.w3.org\/2000\/svg"\n  height={props.size || "1em"}\n  fill={props.color || "lightgray"}\n  viewBox="0 0 512 512"\n  class={props.class}>/')

    # Create the Svelte component file
    cat <<EOF > "$svelte_file"
<script lang="ts">
  const props = \$props();
</script>

$svg_content
EOF

    echo "✅ Created: $svelte_file"

    # Add the component to index.ts
    update_index_file "$component_name"
}

# Loop through all SVG files in the specified directory
for svg in "$INPUT_DIR"/svg/*.svg; do
    if [ -f "$svg" ]; then
        convert_svg_to_svelte "$svg"
    fi
done

echo "🎉 Conversion complete! Components are in '$OUTPUT_DIR', and 'index.ts' has been updated."
