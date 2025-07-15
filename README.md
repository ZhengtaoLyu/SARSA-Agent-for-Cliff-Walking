# 🧠 SARSA for Cliff Walking (MATLAB)

A complete implementation of the SARSA algorithm (State–Action–Reward–State–Action) applied to the classic Cliff Walking problem in reinforcement learning. This project offers a strong demonstration of *on-policy learning*, value function control, and dynamic policy visualization.

---

## 📌 Project Highlights

- ✅ **On-policy TD control** via the SARSA update rule
- ✅ MATLAB-based implementation with **step-level environment logic**
- ✅ Fine-grained **ε-greedy policy update** using cumulative distribution sampling
- ✅ Real-time **return tracking** over 10,000 episodes
- ✅ Visualization of learned **stochastic policy** and most likely path
- ✅ Modular code: core logic, transition dynamics, policy rendering

---

## 💡 Why It Matters

Cliff Walking is a benchmark problem that tests the agent's ability to balance *exploration and exploitation* in a risky environment. Unlike Q-learning (off-policy), SARSA updates the Q-values **based on the action actually taken** under the current policy, resulting in **more cautious and stable learning**.

> This project illustrates how SARSA can lead to safer policies in high-risk zones such as cliffs, a key distinction from value-maximizing approaches like Q-learning.

---

## 🔍 Code Depth & Structure

| File                     | Description                                      |
|--------------------------|--------------------------------------------------|
| `cliff_walking_sarsa.m`  | Main loop, SARSA logic, Q-table update, training |
| `next_state.m`           | Environment transition model + reward structure  |
| `plot_stoch_pol.m`       | Policy arrow visualization + best path tracing   |
| `plot_path.m` *(optional)* | Episode animation for step-by-step trajectories  |

---

## 🔧 Core Algorithm: SARSA

SARSA learns by sampling from the current policy, using the update:


Q(s,a) \leftarrow Q(s,a) + \alpha \cdot \left[ R + \gamma \cdot Q(s', a') - Q(s,a) \right]


This ensures the updates are **policy-aware**, and exploration is directly reflected in Q-values.

---

## 📈 Training Setup

- `alpha = 0.5` (learning rate)
- `gamma = 1.0` (discount factor)
- `epsilon = 0.1` (exploration rate)
- `N = 10,000` episodes
- `Grid size = 5x9` with cliff & goal definitions

The policy is stored as a **cumulative distribution** for efficient sampling via `rand`, and updated with an **ε-greedy** strategy after each step.

---

## 🧠 Visual Outputs

- 📊 **Returns per Episode** (training curve)
- 🧭 **Policy Visualization**: using `quiver` arrows for dominant actions
- 🟥 **Best Path Plotting**: show most probable trajectory from start to goal

---

## 📦 How to Run

```matlab
% Inside MATLAB
cliff_walking_sarsa
