# lex-cognitive-hologram

**Level 3 Leaf Documentation**
- **Parent**: `/Users/miverso2/rubymine/legion/extensions-agentic/CLAUDE.md`
- **Gem**: `lex-cognitive-hologram`

## Purpose

Models holographic memory properties: each piece of a cognitive whole contains information about the whole. Holograms are complete cognitive representations. Fragmentation distributes them across multiple partial fragments. Reconstruction assembles available fragments back into a representation — the quality of reconstruction degrades with fragment loss. Interference measures how much cross-hologram noise has accumulated. Passive degradation over time reduces fidelity without intervention.

## Gem Info

| Field | Value |
|---|---|
| Gem name | `lex-cognitive-hologram` |
| Version | `0.1.0` |
| Namespace | `Legion::Extensions::CognitiveHologram` |
| Ruby | `>= 3.4` |
| License | MIT |
| GitHub | https://github.com/LegionIO/lex-cognitive-hologram |

## File Structure

```
lib/legion/extensions/cognitive_hologram/
  cognitive_hologram.rb             # Top-level require
  version.rb                        # VERSION = '0.1.0'
  client.rb                         # Client class
  helpers/
    constants.rb                    # Max counts, decay rates, thresholds, label arrays
    hologram.rb                     # Hologram value object
    fragment.rb                     # Fragment value object
    hologram_engine.rb              # Engine: holograms, fragments, reconstruction, interference
  runners/
    cognitive_hologram.rb           # Runner module
```

## Key Constants

| Constant | Value | Meaning |
|---|---|---|
| `MAX_HOLOGRAMS` | 100 | Hologram store cap |
| `INTERFERENCE_DECAY` | 0.03 | Interference reduction per maintenance call |
| `RECONSTRUCTION_THRESHOLD` | 0.3 | Minimum fragment coverage to attempt reconstruction |
| `FRAGMENT_LABELS` | array | Labels for fragment count levels |
| `RESOLUTION_LABELS` | array | Labels for resolution (fidelity) levels |
| `FIDELITY_LABELS` | array | `pristine` (0.9+) through `degraded` |
| `INTERFERENCE_LABELS` | array | Labels for interference levels |

## Helpers

### `Hologram`

A complete cognitive representation.

- `initialize(domain:, content:, fidelity: 1.0, hologram_id: nil)`
- `fragment!(count)` — distributes into N fragments; returns Fragment array; reduces fidelity
- `degrade!(rate)` — decreases fidelity by `INTERFERENCE_DECAY`
- `intact?`, `fragmented?`
- `fidelity_label`, `resolution_label`
- `to_h`

### `Fragment`

A partial slice of a hologram.

- `initialize(hologram_id:, content:, coverage:, fragment_id: nil)`
- `coverage` — fraction of the hologram this fragment contains
- `to_h`

### `HologramEngine`

- `create_hologram(domain:, content:, fidelity: 1.0)` — returns `{ created:, hologram_id:, hologram: }` or capacity error
- `fragment_hologram(hologram_id:, count: 3)` — splits hologram into `count` fragments; stores fragments
- `reconstruct_from_fragments(hologram_id:)` — assembles available fragments; requires total fragment coverage >= `RECONSTRUCTION_THRESHOLD`; returns reconstructed hologram with fidelity scaled to coverage
- `measure_interference(hologram_id:)` — returns interference level based on fragment overlap and cross-hologram noise
- `degrade_all!(rate: INTERFERENCE_DECAY)` — reduces fidelity of all holograms
- `best_preserved(limit: 10)` — sorted by fidelity descending
- `most_fragmented(limit: 10)` — sorted by fragment count descending
- `hologram_report` — full stats

## Runners

**Module**: `Legion::Extensions::CognitiveHologram::Runners::CognitiveHologram`

| Method | Key Args | Returns |
|---|---|---|
| `create` | `domain:`, `content:`, `fidelity: 1.0` | `{ success:, hologram_id:, hologram: }` |
| `fragment` | `hologram_id:`, `count: 3` | `{ success:, fragments: [...] }` |
| `reconstruct` | `hologram_id:` | `{ success:, hologram:, fidelity: }` or `{ success: false, reason: :insufficient_fragments }` |
| `list_holograms` | `limit: 50` | `{ success:, holograms:, total: }` |
| `interference_check` | `hologram_id:` | `{ success:, interference:, label: }` |
| `hologram_status` | — | `{ success:, report: }` |

Private: `hologram_engine` — memoized `HologramEngine`. Logs via `log_debug` helper.

## Integration Points

- **`lex-memory`**: Holograms model distributed representation of memory traces. High-fidelity holograms correspond to strong, well-consolidated memory traces; degraded holograms to fading traces.
- **`lex-cognitive-integration`**: Hologram reconstruction parallels multi-modal binding in `lex-cognitive-integration`. Both assemble coherent wholes from partial inputs.
- **`lex-dream`**: The dream cycle's `association_walk` phase could leverage hologram fragment coverage as a salience signal for memory association.

## Development Notes

- `reconstruct_from_fragments` requires fragment coverage sum >= `RECONSTRUCTION_THRESHOLD` (0.3). With fewer than 30% of fragments available, reconstruction fails and returns `{ success: false, reason: :insufficient_fragments }`.
- Fidelity after reconstruction is proportional to total fragment coverage — a 60% fragment set produces ~0.6 fidelity regardless of original quality.
- `degrade_all!` affects all holograms in the store. There is no per-hologram decay protection.
- In-memory only.

---

**Maintained By**: Matthew Iverson (@Esity)
