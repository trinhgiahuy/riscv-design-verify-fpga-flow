ROOTDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RV32_BENCHMARK_DIR="${ROOTDIR}/../rv32-benchmarks"

if [ $# -ne 1 ];then
  echo "USAGE: $0 simple/individuals"
  exit 1
fi

if [[ $1 == *"simple"* ]];then
  PROGRAM_DIR="${RV32_BENCHMARK_DIR}/simple-programs"
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
elif [[ $1 == *"individual"* ]];then
  PROGRAM_DIR="${RV32_BENCHMARK_DIR}/individual-instructions"
  BM_ARR=(
  "rv32ui-p-add"
  "rv32ui-p-addi"
  "rv32ui-p-and"
  "rv32ui-p-andi"
  "rv32ui-p-auipc"
  "rv32ui-p-beq"
  "rv32ui-p-bge"
  "rv32ui-p-bgeu"
  "rv32ui-p-blt"
  "rv32ui-p-bltu"
  "rv32ui-p-bne"
  "rv32ui-p-jal"
  "rv32ui-p-jalr"
  "rv32ui-p-lb"
  "rv32ui-p-lbu"
  "rv32ui-p-lh"
  "rv32ui-p-lhu"
  "rv32ui-p-lui"
  "rv32ui-p-lw"
  "rv32ui-p-or"
  "rv32ui-p-ori"
  "rv32ui-p-sb"
  "rv32ui-p-sh"
  "rv32ui-p-simple"
  "rv32ui-p-sll"
  "rv32ui-p-slli"
  "rv32ui-p-slt"
  "rv32ui-p-slti"
  "rv32ui-p-sltiu"
  "rv32ui-p-sltu"
  "rv32ui-p-sra"
  "rv32ui-p-srl"
  "rv32ui-p-srli"
  "rv32ui-p-sub"
  "rv32ui-p-sw"
  "rv32ui-p-xor"
  "rv32ui-p-xori"
)
else
  echo "UNKNOWN OPTS. AVAILABLE OPTIONS ARE: simple, individual"
  exit 1
fi
MY_BINARY_DIR="${ROOTDIR}/my-binaries"
DATA_DIR="${ROOTDIR}/verif/data"
SIM_DIR="${ROOTDIR}/verif/sim"
SCRIPT_DIR="${ROOTDIR}/verif/scripts"
TEST_DIR="${ROOTDIR}/verif/tests"

passed=0
failed=0
for BM in "${BM_ARR[@]}"; do

  BM_X_FILE="${DATA_DIR}/$BM.x"
  if [ ! -e "${BM_X_FILE}" ];then
    echo "[$BM] File ${BM_X_FILE} does not exist. Copying from rv32-benchmarks directory.."
    cp -p "${PROGRAM_DIR}/${BM}.x" "${BM_X_FILE}"
  fi

  BM_OUTPUT_DIR="${SIM_DIR}/verilator/test_$BM"
  BM_TRACE_FILE="${BM_OUTPUT_DIR}/${BM}.trace"
  BM_VCD_FILE="${BM_OUTPUT_DIR}/${BM}.vcd"
  if [[ ! -d "${BM_OUTPUT_DIR}" || ! -e "${BM_TRACE_FILE}" || ! -e "${BM_VCD_FILE}" ]];then
    echo "[$BM] MISSING EITHER TRACE FILE AND/OR VCD FILE"
    echo "[$BM] RUNNING BENCHMARK.."

    cd $SCRIPT_DIR
    make -s MEM_PATH="${BM_X_FILE}" VCD=1
    #mv "${SIM_DIR}/verilator/test_pd/" "${BM_OUTPUT_DIR}/"
    rsync -a "${SIM_DIR}/verilator/test_pd/" "${BM_OUTPUT_DIR}/"
  else
    echo "[$BM] FOUND TRACE & VCD FILES"


    # PARSE TRACE FILE AND VALIDATE IT
    DISASSEMBLY_FILE="${PROGRAM_DIR}/${BM}.d"
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

    DEST_ADDRESS_OF_JAL=$(grep "\[E\].*${JAL_ADDRESS}" "${BM_TRACE_FILE}" | tail -n1| cut -d" " -f3)
    #echo $DEST_ADDRESS_OF_JAL
    #echo $PASSED_LABEL_ADDRESS
    #exit 1
    if [[ *"${DEST_ADDRESS_OF_JAL}" == *"${PASSED_LABEL_ADDRESS}" ]];then
      echo "[$BM] TEST PASSED!!"
      ((passed++))
    else
      echo '===========FAILED==========='
      echo "[$BM] PASS_LABEL ADDRESS :  ${PASS_LABEL_ADDRESS}"
      echo "[$BM GOT LABLE ADDRESS: ${NEXT_ADDRESS_OF_JAL}"
      echo "[$BM] TEST NOT PASSED!! CHECK TRACE FILE AGAIN!"
      ((failed++))
    fi

    echo ' '
done

echo "================================="
echo "FINISH BENCHMARKING $PROGRAM_DIR"
echo "Total passed - $passed"
echo "Total failed - $failed"
