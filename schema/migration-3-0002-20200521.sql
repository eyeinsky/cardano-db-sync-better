
-- Hand crafted indices for performance
-- These indexes are used by queries db-sync does.
CREATE INDEX IF NOT EXISTS idx_block_slot_no ON block(slot_no);
CREATE INDEX IF NOT EXISTS idx_block_block_no ON block(block_no);
CREATE INDEX IF NOT EXISTS idx_block_epoch_no ON block(epoch_no);
CREATE INDEX IF NOT EXISTS idx_block_previous_id ON block(previous_id);
CREATE INDEX IF NOT EXISTS idx_tx_block_id ON tx(block_id);
CREATE INDEX IF NOT EXISTS idx_reward_spendable_epoch ON reward(spendable_epoch);
CREATE INDEX IF NOT EXISTS idx_epoch_stake_epoch_no ON epoch_stake(epoch_no) ;
CREATE INDEX IF NOT EXISTS idx_pool_metadata_ref_pool_id ON pool_metadata_ref(pool_id);

-- as of 13.2.0.0 offline was renamed to off_chain so we rename previous indexes if they exists
ALTER INDEX IF EXISTS idx_pool_offline_data_pmr_id RENAME TO idx_off_chain_pool_data_pmr_id;
ALTER INDEX IF EXISTS idx_pool_offline_fetch_error_pmr_id RENAME TO idx_off_chain_pool_fetch_error_pmr_id;

CREATE INDEX IF NOT EXISTS idx_off_chain_pool_fetch_error_pmr_id ON off_chain_pool_fetch_error (pmr_id);
CREATE INDEX IF NOT EXISTS idx_off_chain_pool_data_pmr_id ON off_chain_pool_data (pmr_id);
