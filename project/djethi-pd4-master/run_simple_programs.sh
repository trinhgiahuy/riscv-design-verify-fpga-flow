ROOTDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RV32_BENCHMARK_DIR="${ROOTDIR}/../rv32-benchmarks"
SIMPLE_PROGRAM_DIR="${RV32_BENCHMARK_DIR}/simple-programs"
MY_BINARY_DIR="${ROOTDIR}/my-binaries"
DATA_DIR="${ROOTDIR}/verif/data"
SIM_DIR="${ROOTDIR}/verif/sim"
SCRIPT_DIR="${ROOTDIR}/verif/scripts"
TEST_DIR="${ROOTDIR}/verif/tests"


BM_ARR=(
  "BubbleSort"
  "CheckVowel"
  "Fibonacci"
  "SimpleAdd"
  "SimpleIf"
  "SumArray"
  "Swap"
  "SwapShift"
  "fact-short"
)

for BM in "${BM_ARR[@]}";do

  BM_X_FILE="${DATA_DIR}/$BM.x"
  if [ ! -e "${BM_X_FILE}" ];then
    echo "[$BM] File ${BM_X_FILE} does not exist. Copying from rv32-benchmarks directory.."
    cp -p "${SIMPLE_PROGRAM_DIR}/${BM}.x" "${BM_X_FILE}"
  fi

  BM_OUTPUT_DIR="${SIM_DIR}/verilator/test_$BM"
  BM_TRACE_FILE="${BM_OUTPUT_DIR}/${BM}.trace"
  BM_VCD_FILE="${BM_OUTPUT_DIR}/${BM}.vcd"
  if [[ ! -d "${BM_OUTPUT_DIR}" || ! -e "${BM_TRACE_FILE}" || ! -e "${BM_VCD_FILE}" ]];then
    echo "[$BM] MISSING EITHER TRACE FILE AND/OR VCD FILE"
    echo "[$BM] RUNNING BENCHMARK.."

    cd $SCRIPT_DIR
    #make -s TEST="test_${BM}" MEM_PATH="${BM_X_FILE}" VCD=1
    make -s MEM_PATH="${BM_X_FILE}" VCD=1
    mv "${SIM_DIR}/verilator/test_pd/" "${BM_OUTPUT_DIR}/"
  else
    echo "[$BM] FOUND TRACE & VCD FILES"


    # PARSE TRACE FILE AND VALIDATE IT
    DISASSEMBLY_FILE="${SIMPLE_PROGRAM_DIR}/${BM}.d"
    DISASSEMBLY_FILE_CP="${ROOTDIR}/${BM}.d"
    if [ ! -e "${DISASSEMBLY_FILE_CP}" ]; then cp -p $DISASSEMBLY_FILE $DISASSEMBLY_FILE_CP; fi
    # The file we're scanning

    # Temporary file to hold the relevant block of disassembly
    temp_block_file="temp_block.d"
    inside_test_block=0
  fi
    while read -r line; do
        # Check if we have reached the test label
        if [[ $line == *" <test>:"* ]]; then
            inside_test_block=1
            # Empty the temp block file
            > "$temp_block_file"
            continue
        fi

        # If we are inside the test block
        if [ "$inside_test_block" -eq 1 ]; then
            # Append the line to the temp block file
            echo "$line" >> "$temp_block_file"

            # Check for the pass instruction
            if [[ $line == *"pass"* ]]; then
                # Extract the address of the jal <pass> instruction inside test block code
                JAL_ADDRESS=$(echo "$line" | cut -d ":" -f1)
                JAL_REST=$(echo "$line" | cut -d ":" -f2)
                PASSED_LABEL_ADDRESS=$(echo $JAL_REST | awk '/<pass>/{for(i=1;i<=NF;i++)if($i=="<pass>"){print $(i-1)}}' | cut -d',' -f2)

                # Output the found address
                echo "[$BM] FOUND PASSED ADDRESS IN TEST BLOCK: $PASSED_LABEL_ADDRESS"
                # We can break if we assume there's only one ret in the test block
                break
            fi
        fi

        # Check for the next label to end the test block scan
        if [[ $line == *"<"* ]] && [[ $line == *">:"* ]] && [ "$inside_test_block" -eq 1 ]; then
            # End the test block
            inside_test_block=0
        fi

    done < "${DISASSEMBLY_FILE_CP}"

    NEXT_ADDRESS_OF_JAL=$(grep "\[F\].*${JAL_ADDRESS}" "${BM_TRACE_FILE}" -A6 | tail -n1| cut -d" " -f2)
    if [[ *"${NEXT_ADDRESS_OF_JAL}" == *"${PASSED_LABEL_ADDRESS}" ]];then
      echo "[$BM] TEST PASSED!!"
    else
      echo '===========FAILED==========='
      echo "[$BM] PASS_LABEL ADDRESS :  ${PASS_LABEL_ADDRESS}"
      echo "[$BM GOT LABLE ADDRESS: ${NEXT_ADDRESS_OF_JAL}"
      echo "[$BM] TEST NOT PASSED!! CHECK TRACE FILE AGAIN!"
    fi

    echo ' '
done

echo "FINISH BENCHMARKING SIMPLE-PROGRAMAS"
