import { HfInference } from '@huggingface/inference';
import { throwIfMissing } from './utils.js';

export default async ({ req, res }) => {
  throwIfMissing(process.env, ['HUGGINGFACE_ACCESS_TOKEN']);

  if (req.method === 'GET') return res.json({ ok: false }, 400);

  if (!req.bodyJson.prompt) return res.json({ ok: false, error: 'Prompt is required.' }, 400);

  const hf = new HfInference(process.env.HUGGINGFACE_ACCESS_TOKEN);

  try {
    let response = await hf.chatCompletion({
      model: "Qwen/Qwen2.5-72B-Instruct",
      messages: [
        { role: "system", content: "You are participating in a game where you chose the character 'Saitama'. The user will ask you question to guess the character you chose. You can only anwer with Yes or No." },
        { role: "user", content: req.bodyJson.prompt }],
      max_tokens: 5,
    })
    
    return res.json({ ok: true, completion: response.choices[0].message }, 200);
  } catch (err) {
    console.error(err);
    return res.json({ ok: false, error: 'Failed to query model.' }, 500);
  }
};
