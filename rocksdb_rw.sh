./db_bench \
--benchmarks="readrandomwriterandom,stats" \
--enable_write_thread_adaptive_yield=false \
--disable_auto_compactions=false \
--max_background_compactions=32 \
--max_background_flushes=4 \
--write_buffer_size=536870912 \
--min_write_buffer_number_to_merge=2 \
--max_write_buffer_number=6 \
--target_file_size_base=67108864 \
--max_bytes_for_level_base=536870912 \
--use_existing_keys=1 \
--use_existing_db=1 \
--cache_size=2147483648 \
--readwritepercent=80 \
--key_id_range=100000000 \
--num=10000000 \
--duration=0 \
--threads=1 \
--value_size=131072 \
--key_size=16 \
--enable_pipelined_write=true \
--db=/ks_grace_data/bench_test \
--wal_dir=/ks_grace_data/bench_test \
--allow_concurrent_memtable_write=true \
--disable_wal=true

